/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.lisproject.object.Amministratore;
import java.util.Map;
import javax.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("login")
@SessionAttributes("user")
public class LoginController {

    //@ModelAttribute("user")
    @RequestMapping(method = RequestMethod.GET)
    public String showLogin(Model model) {
        model.addAttribute("userCredential", new UserCredential());
        return "login";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String processForm(@ModelAttribute("userCredential") @Valid UserCredential user, BindingResult result,
            Map model) {
        
        //-- mock values, dovra collegarsi al ws
        String userName = "admin";
        String password = "admin";
        //--
        
        if (result.hasErrors()) {
            return "login";
        }
        user = (UserCredential) model.get("userCredential");
        if (!user.getUserName().equals(userName)
                || !user.getPassword().equals(password)) {
            return "login";
        }
        model.put("user", new Amministratore(user.getUserName(), user.getUserName()));
        
        return "redirect:/map";
    }
}
