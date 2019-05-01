
package services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.ControlPointRepository;
import domain.ControlPoint;
import domain.Route;
import forms.ControlPointFormCreate;

@Service
@Transactional
public class ControlPointService {

	//Managed service

	@Autowired
	private ControlPointRepository	controlPointRepository;

	//Supporting service

	@Autowired
	private ActorService			actorService;

	@Autowired
	private RouteService			routeService;


	//Simple CRUD methods

	public ControlPoint create() {
		final ControlPoint c = new ControlPoint();
		c.setArrivalOrder(0);
		c.setArrivalTime(new Date());
		c.setDistance(0d);

		return c;
	}

	/*
	 * public ControlPoint create(final int routeId) {
	 * 
	 * final ControlPoint c = new ControlPoint();
	 * 
	 * final Route route = this.routeService.findOne(routeId);
	 * c.setRoute(route);
	 * 
	 * Driver driver = (Driver) this.actorService.findByPrincipal();
	 * Assert.isTrue(route.getDriver().getId() == driver.getId());
	 * 
	 * if(route.getControlPoints().isEmpty()){
	 * c.setArrivalOrder(0);
	 * } else{
	 * c.setArrivalOrder(route.getControlPoints().size());
	 * }
	 * 
	 * return c;
	 * }
	 */

	public Collection<ControlPoint> findAll() {
		return this.controlPointRepository.findAll();
	}

	public ControlPoint findOne(final int id) {
		Assert.notNull(id);

		return this.controlPointRepository.findOne(id);
	}
	
	public ControlPoint save2(final ControlPoint controlPoint) {
		Assert.notNull(controlPoint);
		final ControlPoint saved = controlPointRepository.saveAndFlush(controlPoint);
		return saved;
	}
	
	public void flush() {
		controlPointRepository.flush();
	}

	public ControlPoint save(final ControlPoint controlPoint) {
		Assert.notNull(controlPoint);

		//Assertion that the user deleting this note has the correct privilege.
		Assert.isTrue(this.actorService.findByPrincipal().getId() == controlPoint.getRoute().getDriver().getId());
		final Route route = controlPoint.getRoute();
		final Collection<ControlPoint> controls = route.getControlPoints();

		final List<ControlPoint> cps = new ArrayList<ControlPoint>(controls);
		cps.add(controlPoint);
		Collections.sort(cps);

		if (cps.size() <= 1 || cps.indexOf(controlPoint) != 0)
			controlPoint.setDistance(0.0);
		else
			controlPoint.setDistance(this.routeService.getDistance(cps.get(cps.indexOf(controlPoint) - 1).getLocation(), controlPoint.getLocation()));

		final ControlPoint saved = this.controlPointRepository.save(controlPoint);
		controls.add(saved);

		this.routeService.save(route);

		return saved;
	}

	public void delete(final ControlPoint controlPoint) {
		Assert.notNull(controlPoint);

		//Assertion that the user deleting this note has the correct privilege.
		Assert.isTrue(this.actorService.findByPrincipal().getId() == controlPoint.getRoute().getDriver().getId());

		this.controlPointRepository.delete(controlPoint);

		final Route route = controlPoint.getRoute();
		final Collection<ControlPoint> controls = route.getControlPoints();
		controls.remove(controlPoint);

		if (route.getControlPoints().size() >= 2) {
			final List<ControlPoint> cps = new ArrayList<ControlPoint>(controls);
			Collections.sort(cps);
			int order = 0;
			for (final ControlPoint a : cps) {
				a.setArrivalOrder(order);
				order++;
				this.controlPointRepository.save(a);
			}
		}

		this.routeService.save(route);

	}

	public Double getDistanceTwoPoints(final ControlPoint start, final ControlPoint end, final Route c) {
		Assert.isTrue(c.getControlPoints().contains(start) && c.getControlPoints().contains(end));
		final List<ControlPoint> cps = new ArrayList<ControlPoint>(c.getControlPoints());
		Collections.sort(cps);
		Double distance = 0.0;
		int ok = 0;
		for (final ControlPoint a : cps)
			if (a.equals(start) || a.equals(end)) {
				if (ok >= 1)
					distance = distance + a.getDistance();
				ok++;
				if (ok < 2)
					break;
			}
		return distance;

	}

	public ControlPointFormCreate constructCreate(final ControlPoint controlPoint, Route route) {
		final ControlPointFormCreate form = new ControlPointFormCreate();
		form.setLocation(controlPoint.getLocation());
		form.setArrivalOrder(controlPoint.getArrivalOrder());
		if (route != null && route.getControlPoints() != null && route.getControlPoints().size() > 1) {
			Date lastArrivalTime = null;
			for (ControlPoint cp : route.getControlPoints()) {
				if (cp.getArrivalOrder() == controlPoint.getArrivalOrder()) {
					if (lastArrivalTime == null) {
						form.setEstimatedTime(0);
						break;
					}
					else {
						Double estimatedTime = (cp.getArrivalTime().getTime() - lastArrivalTime.getTime()) / 60000d;
						form.setEstimatedTime(estimatedTime.intValue());
						break;
					}
				}
				else {
					lastArrivalTime = cp.getArrivalTime();
				}
			}
		}
		else {
			form.setEstimatedTime(0);
		}
		/*if (controlPoint.getRoute() == null) {
			form.setEstimatedTime(0);
		}
		else {
			// TODO
			form.setEstimatedTime(0);
		}*/
		form.setDistance(controlPoint.getDistance());
		return form;
	}
	
	public List<ControlPoint> reconstructCreate(Collection<ControlPointFormCreate> controlPoints, Date departureDate) {
		TreeSet<ControlPoint> result = new TreeSet<ControlPoint>();
		ControlPoint cp;
		String lastLocation = null;
		int order = 0;
		int acumulatedTime = 0;
		for (ControlPointFormCreate cpForm: controlPoints) {
			Assert.isTrue(order == cpForm.getArrivalOrder());
			Assert.isTrue((order == 0 && cpForm.getEstimatedTime() == 0) || (order != 0 && cpForm.getEstimatedTime() > 0));
			cp = create();
			cp.setArrivalOrder(order);
			cp.setLocation(cpForm.getLocation());
			if (lastLocation != null) {
				cp.setDistance(routeService.getDistance(lastLocation, cpForm.getLocation()));
			}
			else {
				cp.setDistance(0d);
			}
			lastLocation = cpForm.getLocation();
			acumulatedTime += cpForm.getEstimatedTime();
			cp.setArrivalTime(new Date(departureDate.getTime() + acumulatedTime * 60000));
			order++;
			
			result.add(cp);
		}
		return new ArrayList<ControlPoint>(result);
	}

}
