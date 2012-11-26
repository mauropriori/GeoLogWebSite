/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import com.lisproject.object.Coordinata;
import com.lisproject.object.POIBase;
import com.lisproject.object.poi.POIAlloggio;
import controller.SearchParamethers;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author m.priori-cons
 */
public class PoisService {
    public static List<POIBase> LoadPois(SearchParamethers searchParamethers)
    {
        //mock values
        List<POIBase> pois = new ArrayList<POIBase>();
        
        POIBase poi = new POIAlloggio("Alloggio", 0, searchParamethers.getNome(), searchParamethers.getDescrizione(), 5);
        poi.setIdentificativo(1);
        poi.setCoordinate(new Coordinata(41.0, 14.1));
        pois.add(poi);
        
        poi = new POIAlloggio("Alloggio", 0, searchParamethers.getNome(), searchParamethers.getDescrizione(), 5);
        poi.setIdentificativo(2);
        poi.setCoordinate(new Coordinata(42.3, 12.1));
        pois.add(poi);

        return pois;
    }

    public static Boolean DeletePoi(int parseInt) {
        
        //fa qualcosa
        return true;
    }
    
    public static Boolean EditPoi(POIBase poi)
    {
        return true;
    }

    public static POIBase GetPoiDetail(int parseInt) {
        POIBase poi = new POIAlloggio("Alloggio", 0, "nome", "descrizione", 5);
        poi.setIdentificativo(1);
        poi.setCoordinate(new Coordinata(41.2, 14.1));
        
        return poi;
    }
}
