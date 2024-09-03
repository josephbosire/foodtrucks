"use client";
import { Marker } from "react-leaflet/Marker";
import { useEffect, useState } from "react";
import { Icon } from "leaflet";
import { Popup } from "react-leaflet/Popup";
import { Truck } from "../lib/types";
import TruckMenu from "./Menu";

const DEFAULT_PUBLIC_API_URL = "http://localhost:4000";
const TruckLocationMarker = () => {
  const initialMarkers: Truck[] = [];
  const [markers, setMarkers] = useState<Truck[]>(initialMarkers);

  const get_trucks = async () => {
    const response = await fetch(
      `${process.env.PUBLIC_API_URL || DEFAULT_PUBLIC_API_URL}/api/trucks`
    );
    const result = await response.json();
    setMarkers(result.data);
  };

  const truckIcon = new Icon({
    iconUrl:
      "https://img.icons8.com/external-nawicon-outline-color-nawicon/64/external-food-truck-fast-food-nawicon-outline-color-nawicon.png",
    iconSize: [35, 35], // size of the icon
    iconAnchor: [22, 94], // point of the icon which will correspond to marker's location
    popupAnchor: [-3, -76], // point from which the popup should open relative to the iconAnchor
  });
  const cartIcon = new Icon({
    iconUrl: "https://img.icons8.com/color/48/stall.png",
    iconSize: [35, 35], // size of the icon
    iconAnchor: [22, 94], // point of the icon which will correspond to marker's location
    popupAnchor: [-3, -76], // point from which the popup should open relative to the iconAnchor
  });

  const getCategoryIcon = (category: string) => {
    if (category === "truck") {
      return truckIcon;
    } else {
      // Default icon if category doesn't match any of the above
      return cartIcon; // Or another default icon
    }
  };

  useEffect(() => {
    if (markers.length === 0) {
      get_trucks().catch(console.error);
    }
  }, []);

  return (
    <>
      {markers.map((marker) => (
        <Marker
          icon={getCategoryIcon(marker.type)}
          key={marker.id}
          title={marker.name}
          position={[
            marker.locations[0].latitude,
            marker.locations[0].longitude,
          ]}
        >
          <Popup>
            <b>{marker.name}</b>
            <br />
            <em>{marker.address}</em>
            <br />
            Category: {marker.type}
            <br />
            <TruckMenu menu_items={marker.menu_items} />
          </Popup>
        </Marker>
      ))}
    </>
  );
};

export default TruckLocationMarker;
