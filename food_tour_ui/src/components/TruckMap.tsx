"use client";
import { MapContainer } from "react-leaflet/MapContainer";
import { TileLayer } from "react-leaflet/TileLayer";
import { useMap } from "react-leaflet/hooks";
import { Popup } from "react-leaflet/Popup";
import { Marker } from "react-leaflet/Marker";
import TruckLocationMarker from "./TruckLocationMarker";

const TruckMap = () => {
  const mapCenteLat = 37.773972;
  const mapCenteLng = -122.431297;

  return (
    <div>
      <MapContainer
        center={[mapCenteLat, mapCenteLng]}
        zoom={13}
        scrollWheelZoom={false}
      >
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        <TruckLocationMarker />
      </MapContainer>
    </div>
  );
};

export default TruckMap;
