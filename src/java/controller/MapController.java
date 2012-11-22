/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.lisproject.object.Amministratore;
import com.lisproject.object.Coordinata;
import com.lisproject.object.POIBase;
import com.lisproject.object.poi.POIAlloggio;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import service.PoisService;

@Controller
@RequestMapping("map")
@SessionAttributes("searchParamethers")
public class MapController {
    @RequestMapping(method = RequestMethod.GET)
    public String showMappaPoi(Map model)
    {
        Object sp = model.get("searchParamethers");
        if (sp == null)
        {
            model.put("searchParamethers", new SearchParamethers());
        }
        else
        {
            List<POIBase> pois = PoisService.LoadPois((SearchParamethers)sp);
        
            model.put("pois", pois);
        }
        return "map";
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String processForm(@ModelAttribute("searchParamethers") SearchParamethers searchParamethers,
            Map model) {
        //searchParamethers = (SearchParamethers) model.get("searchParamethers");
        
        List<POIBase> pois = PoisService.LoadPois((SearchParamethers)searchParamethers);

        model.put("pois", pois);
        
        return "map";
    }
}
