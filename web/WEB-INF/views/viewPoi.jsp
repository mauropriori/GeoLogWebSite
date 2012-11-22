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
                var mapOptions = {
                    center: new google.maps.LatLng(${poi.coordinate.latitude},${poi.coordinate.longitude}),
                    zoom: 12,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                
                var map = new google.maps.Map(document.getElementById("map_canvas"),
                mapOptions);
                
                //Creazione InfoWindow
                var infowindow = new google.maps.InfoWindow();
                var marker = null;
                
                //Singolo Poi fittizio
                marker = new google.maps.Marker({
                    position: new google.maps.LatLng(<c:out value="${poi.coordinate.latitude}"/>, <c:out value="${poi.coordinate.longitude}"/>),
                    map: map,
                    title: '<c:out value="${poi.nome}"/>'
                });

                google.maps.event.addListener(marker, 'click', (function(marker) {
                    return function() 
                    {
                      infowindow.setContent('<strong><c:out value="${poi.nome}"/></strong>' + 
                          '<a href="poi/delete/<c:out value="${poi.identificativo}"/>" onclick="return confirmDelete();">Elimina</a></br>' +
                          '<a href="poi/edit/<c:out value="${poi.identificativo}"/>">Modifica</a></br>');
                      infowindow.open(map, marker);
                    }
                  })(marker));
            }
        </script>
    </head>
    <body onload="initialize()">
        <h1>Ciao ${user.nickname}</h1>
        <p>
            Torna alla <a href="map">pagina</a> di ricerca.
        </p>
        <div style="position:absolute; left:0; width:300px; height:100%">
            <form:form action="viewPoi" commandName="poi">
                <fieldset>		
                    <legend>Cerca</legend>
                    <p>	
                        <form:label for="identificativo" path="identificativo">Identificativo</form:label><br/>
                        <form:label path="identificativo" />
                    </p>
                    <p>
                        <form:label for="nome" path="nome">Nome</form:label><br/>
                        <form:label path="nome" /> 			
                    </p>
                    <p>	
                        <form:label for="descrizione" path="descrizione">Descrizione</form:label><br/>
                        <form:label path="descrizione" />
                    </p>
                </fieldset>
            </form:form>
        </div>
        <div id="map_canvas" style="position:absolute; margin-left:300px; width: 80%; height:100%"></div>
    </body>
</html>
