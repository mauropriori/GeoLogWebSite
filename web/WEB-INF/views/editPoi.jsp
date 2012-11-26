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
                    draggable:true,
                    map: map,
                    title: '<c:out value="${poi.nome}"/>'
                });
                
                google.maps.event.addListener(marker, 'dragend', function() 
                {
                    $("#latitude").val(marker.getPosition().lat());
                    $("#longitude").val(marker.getPosition().lng());
                    
                    geocodePosition(marker.getPosition());
                });
                
                geocodePosition(poiPoint);
            };
            
            function geocodePosition(point)
            {
                //Visualizzazione indirizzo
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'latLng': point }, function(results, status)
                {
                    if (status == google.maps.GeocoderStatus.OK) 
                        $("#indirizzo").text("Indirizzo: " + results[0].formatted_address);
                    else
                        $("#indirizzo").text("");
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
            <form:form action="${poi.identificativo}" commandName="poi" >
                <fieldset>
                    <legend>Dettagli</legend>
                    <p>
                        <form:label for="identificativo" path="identificativo">Identificativo:</form:label><br/>
                        <form:input path="identificativo" /> <form:errors path="identificativo" />	
                    </p>
                    <p>
                        <form:label for="nome" path="nome">Nome:</form:label><br/>
                        <form:input path="nome" /> <form:errors path="nome" />			
                    </p>
                    <p>	
                        <form:label for="descrizione" path="descrizione">Descrizione:</form:label><br/>
                        <form:input path="descrizione" /> <form:errors path="descrizione" />
                    </p>
                    <p>	
                        <form:label for="coordinate.latitude" path="coordinate.latitude">Latitudine:</form:label><br/>
                        <form:input id="latitude" path="coordinate.latitude" readonly="true"/> <form:errors path="coordinate.latitude" />
                    </p>
                    <p>	
                        <form:label for="coordinate.longitude" path="coordinate.longitude">Longitudine:</form:label><br/>
                        <form:input id="longitude" path="coordinate.longitude" readonly="true"/> <form:errors path="coordinate.longitude" />
                    </p> 
                    <p id="indirizzo" />
                    <c:if test="${poi.idTipo == '0'}">  
                        <p>	
                        <form:label for="stelle" path="stelle">Stelle:</form:label><br/>
                        <form:input path="stelle" /> <form:errors path="stelle" />
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
                        <form:label for="webSite" path="webSite">Sito Web:</form:label><br/>
                        <form:input path="webSite" /> <form:errors path="stelle" />
                        </p> 
                        <p>	
                        <form:label for="valutazioneGamberoRosso" path="valutazioneGamberoRosso">Valutazione:</form:label><br/>
                        <form:input path="valutazioneGamberoRosso" /> <form:errors path="valutazioneGamberoRosso" />
                        </p> 
                    </c:if> 
                    <c:if test="${poi.idTipo == '7'}"> 
                        <p>	
                        <form:label for="webSite" path="webSite">Sito Web:</form:label><br/>
                        <form:input path="webSite" /> <form:errors path="stelle" />
                        </p> 
                    </c:if> 
                    <c:if test="${poi.idTipo == '9'}"> 
                        <p>	
                        <form:label for="tipoTrasporto" path="tipoTrasporto">Tipo Trasporto:</form:label><br/>
                        <form:input path="tipoTrasporto" /> <form:errors path="tipoTrasporto" />
                        </p> 
                    </c:if> 
                    <p>	
                        <input type="submit" />
                    </p>
                </fieldset>
            </form:form>
            <p><a href="../delete/${poi.identificativo}" onclick="return confirmDelete();">Cancella</a></p>
        </div>
        <div id="map_canvas" style="position:absolute; margin-left:300px; width: 80%; height:100%"></div>
    </body>
</html>
