"use client";
import { MenuItem } from "../lib/types";

type MenuProps = {
  menu_items: MenuItem[];
};
const TruckMenu: React.FC<MenuProps> = ({ menu_items }) => {
  return (
    <>
      <p className="text-lg font-bold">Menu</p>
      <ul>
        {menu_items.map((item) => (
          <li>{item.item_name}</li>
        ))}
      </ul>
    </>
  );
};

export default TruckMenu;
