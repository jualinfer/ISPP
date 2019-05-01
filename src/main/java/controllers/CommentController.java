
package controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import services.CommentService;
import domain.Comment;
import forms.CommentForm;

@Controller
@RequestMapping("/comment")
public class CommentController extends AbstractController {

	@Autowired
	private CommentService	commentService;


	// Constructor ------------------------------
	public CommentController() {
		super();
	}

	@RequestMapping(value = "/create", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid CommentForm commentForm, BindingResult binding, RedirectAttributes redir, @RequestParam(required = false) Integer passengerId) {

		ModelAndView res;
		Comment comment;

		try {
			res = new ModelAndView("redirect:../route/display.do?routeId=" + String.valueOf(commentForm.getRoute().getId()));

			if (binding.hasErrors()) {
				redir.addFlashAttribute("commentResultError", "comment.created.error");
				return res;
			}

			comment = this.commentService.reconstruct(commentForm, passengerId);

			this.commentService.save(comment);
			redir.addFlashAttribute("commentResultOk", "comment.created.ok");
			return res;

		} catch (Throwable oops) {
			res = new ModelAndView("redirect:/");
		}

		return res;

	}
}
