/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import poiServices.POIBase;
import service.PoisService;

@Controller
@RequestMapping("map")
@SessionAttributes("searchParamethers")
public class MapController {
    @RequestMapping(method = RequestMethod.GET)
    public String showMappaPoi(Map model)
    {
        SearchParamethers sp = (SearchParamethers)model.get("searchParamethers");
        if (sp == null)
        {
            sp = new SearchParamethers();
            sp.setLatitudine(41.881831);
            sp.setLongitudine(12.505188);

            model.put("searchParamethers", sp);
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
