<%-- 
    Document   : mappaPoi
    Created on : 4-nov-2012, 12.34.15
    Author     : Mauro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GeoLog</title>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
        <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
        <style type="text/css">
            html { height: 100% }
            body { height: 100%; margin: 0; padding: 0 }
            #map_canvas { height: 100% }
        </style>
        <script type="text/javascript"
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC350L97gjAJXR2kRsGPhKFwonwWsG3_E0&sensor=false">
        </script>
        <script type="text/javascript">
            var map;
            
            function initializeMap() {
                var mapOptions = {
                    center: new google.maps.LatLng(<c:out value="${searchParamethers.latitudine}"/>, <c:out value="${searchParamethers.longitudine}"/>),
                    zoom: 10,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                
                map = new google.maps.Map(document.getElementById("map_canvas"),
                mapOptions);
                
                //Creazione InfoWindow
                var infowindow = new google.maps.InfoWindow();
                var marker = null;
                
                <c:forEach items="${pois}" var="poi">
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
                              '</br>Descrizione: <c:out value="${poi.descrizione}"/> </br>' + 
                              'Latitudine:<c:out value="${poi.coordinate.latitude}"/></br>' + 
                              'Longitudine:<c:out value="${poi.coordinate.longitude}"/></br>' + 
                              '<a href="poi/delete/<c:out value="${poi.identificativo}"/>" onclick="return confirmDelete();">Elimina</a></br>' +
                              '<a href="poi/edit/<c:out value="${poi.identificativo}"/>">Modifica</a></br>' +
                              '<a href="poi/view/<c:out value="${poi.identificativo}"/>">Dettagli</a>');
                          infowindow.open(map, marker);
                        }
                      })(marker));
                </c:forEach>
            }
            
            function codeAddress() 
            {
                var address = $("#indirizzo").val();
                
                if (address != "")
                {
                    var geocoder = new google.maps.Geocoder();

                    geocoder.geocode({ 'address': address}, function(results, status)
                    {
                        $("#latitudine").val(results[0].geometry.location.lat());
                        $("#longitudine").val(results[0].geometry.location.lng());
                        map.setCenter(new google.maps.LatLng(results[0].geometry.location.lat(),results[0].geometry.location.lng()), 14);

                        $("#formCerca").submit();
                    });

                    $("#formCerca").unbind("submit");
                    return false;
                }
                else
                {
                    return true;
                }
            };
            
            function confirmDelete() {
                var answer = confirm('Sei sicuro di voler cancellare il Punto di Interesse selezionato?');
                if(!answer){
                    return false;
                }
            };
          
            $(document).ready(function () { 
                geocoder = new google.maps.Geocoder();

                $("#formCerca").bind("submit",function() {
                    return codeAddress();
                });
            }); 
        </script>
    </head>
    <body onload="initializeMap()">
        <h1>Ciao ${user.nickname}</h1>

        <div style="position:absolute; left:0; width:300px; height:100%">
            <form:form id="formCerca" action="map" commandName="searchParamethers">
                <fieldset>		
                    <legend>Cerca</legend>
                    <p>
                        <form:label for="nome" path="nome">Nome</form:label><br/>
                        <form:input path="nome" /> 			
                    </p>
                    <p>	
                        <form:label for="descrizione" path="descrizione">Descrizione</form:label><br/>
                        <form:input path="descrizione" />
                    </p>                    
                    <p>	
                        <form:label for="indirizzo" path="indirizzo">Paese e/o Indirizzo</form:label><br/>
                        <form:input id="indirizzo" path="indirizzo" />
                        <form:hidden id="latitudine" path="latitudine" /> 
                        <form:hidden id="longitudine" path="longitudine" /> 
                    </p>
                    <p>	
                        <input type="submit" />
                    </p
                </fieldset>
            </form:form>
            
        </div>
        <div id="map_canvas" style="position:absolute; margin-left:300px; width: 80%; height:100%"></div>
    </body>
</html>

