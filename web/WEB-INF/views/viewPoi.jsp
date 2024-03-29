<%-- 
    Document   : ViewPoi
    Created on : 19-nov-2012, 14.33.50
    Author     : m.priori-cons
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GeoLog - Visualizza Info POI</title>
        <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
        <style type="text/css">
            html { height: 100% }
            body { height: 100%; margin: 0; padding: 0 }
            #map_canvas { height: 100% }
        </style>
        <script type="text/javascript"
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC350L97gjAJXR2kRsGPhKFwonwWsG3_E0&sensor=false">
        </script>
        <script type="text/javascript">
            function initialize() {                
                var poiPoint = new google.maps.LatLng(<c:out value="${poi.coordinate.latitude}"/>, <c:out value="${poi.coordinate.longitude}"/>)
                
                var mapOptions = {
                    center: poiPoint,
                    zoom: 14,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                
                var map = new google.maps.Map(document.getElementById("map_canvas"),
                mapOptions);
                
                var marker = new google.maps.Marker({
                    position: poiPoint,
                    map: map,
                    title: '<c:out value="${poi.nome}"/>'
                });
                
                //Visualizzazione indirizzo
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'latLng': poiPoint }, function(results, status)
                {
                    if (status == google.maps.GeocoderStatus.OK) 
                    {
                        $("#indirizzo").text("Indirizzo: " + results[0].formatted_address);
                    }
                });
            };
            
            function confirmDelete() {
                var answer = confirm('Sei sicuro di voler cancellare il Punto di Interesse selezionato?');
                if(!answer){
                    return false;
                }
            };
        </script>
    </head>
    <body onload="initialize()">
        <h1>Ciao ${user.nickname}</h1>
        <p>
            Torna alla <a href="../../map">pagina</a> di ricerca.
        </p>
        <div style="position:absolute; left:0; width:300px; height:100%">
                <fieldset>		
                    <legend>Dettagli</legend>
                    <p>	
                        Identificativo: ${poi.identificativo}
                    </p>
                    <p>
                        Nome: ${poi.nome}			
                    </p>
                    <p>	
                        Descrizione: ${poi.descrizione}
                    </p>
                    <p>	
                        Latitudine: ${poi.coordinate.latitude}
                    </p>
                    <p>	
                        Longitudine: ${poi.coordinate.longitude}
                    </p> 
                    <p id="indirizzo" />
                    <c:if test="${poi.idTipo == '0'}">  
                        <p>	
                        Stelle: ${poi.stelle}
                        </p>  
                    </c:if> 
                    <c:if test="${poi.idTipo == '4'}">   
                        <p>	
                        Gratis: ${poi.isGratis}
                        </p> 
                    </c:if> 
                    <c:if test="${poi.idTipo == '5'}">   
                        <p>	
                        GPL: ${poi.hasGpl}
                        </p> 
                        <p>	
                        Metano: ${poi.hasMetano}
                        </p> 
                    </c:if> 
                    <c:if test="${poi.idTipo == '6'}"> 
                        <p>	
                        Sito Web: ${poi.webSite}
                        </p> 
                        <p>	
                        Valutazione: ${poi.valutazioneGamberoRosso}
                        </p> 
                    </c:if> 
                    <c:if test="${poi.idTipo == '7'}"> 
                        <p>	
                        Sito Web: ${poi.webSite}
                        </p> 
                    </c:if> 
                    <c:if test="${poi.idTipo == '9'}"> 
                        <p>	
                        Tipo Trasporto: ${poi.tipoTrasporto}
                        </p> 
                    </c:if> 
                </fieldset>
                    <p><a href="../delete/${poi.identificativo}" onclick="return confirmDelete();">Cancella</a></p>
                    <p><a href="../edit/${poi.identificativo}">Modifica</a></p>
        </div>
        <div id="map_canvas" style="position:absolute; margin-left:300px; width: 80%; height:100%"></div>
    </body>
</html>
