/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import controller.SearchParamethers;
import java.util.ArrayList;
import java.util.List;
import poiServices.HelloAxisService;
import poiServices.POIAlloggio;
import poiServices.POIBase;

/**
 *
 * @author m.priori-cons
 */
public class PoisService {
    public static List<POIBase> LoadPois(SearchParamethers searchParamethers)
    {
        //mock values
        List<POIBase> pois = new ArrayList<POIBase>();

        return pois;
    }

    public static Boolean DeletePoi(int parseInt) {
        
        HelloAxisService service = new HelloAxisService();
        POIAlloggio serverResponse = service.getHelloAxisServiceSOAP11PortHttp().getPoiAlloggio().getReturn().getValue();

        //fa qualcosa
        return true;
    }
    
    public static Boolean EditPoi(POIBase poi)
    {
        return true;
    }

    public static POIBase GetPoiDetail(int parseInt) {
        POIBase poi = new POIAlloggio();
        
        return poi;
    }
}
