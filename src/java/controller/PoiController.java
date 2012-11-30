/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import poiServices.POIBase;
import service.PoisService;

@Controller
@RequestMapping("poi")
public class PoiController {
    
    @RequestMapping(value="delete/{id}", method = RequestMethod.GET)
    public String deletePoi(@PathVariable String id, Map model)
    {
        PoisService.DeletePoi(Integer.parseInt(id));
        
        return "redirect:/map";
    } 
    
    @RequestMapping(value="edit/{id}", method = RequestMethod.GET)
    public String editPoi(@PathVariable String id, Map model)
    {
        model.put("poi", PoisService.GetPoiDetail(Integer.parseInt(id)));
        
        return "/editPoi";
    }    
    @RequestMapping(value="edit", method = RequestMethod.POST)
    public String editPoiDoAction(@ModelAttribute("poi") POIBase poi, Map model)
    {
        PoisService.EditPoi(poi);
                
        return "/editPoi";
    }
        
    @RequestMapping(value="view/{id}", method = RequestMethod.GET)
    public String viewPoi(@PathVariable String id, Map model)
    {
        model.put("poi", PoisService.GetPoiDetail(Integer.parseInt(id)));
        
        return "/viewPoi";
    }
}
