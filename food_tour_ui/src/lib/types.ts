export type MenuItem = {
  id: number;
  inserted_at: string;
  updated_at: string;
  truck_id: number;
  item_name: string;
};

export type Truck = {
  block: string;
  id: number;
  name: string;
  status: string;
  type: string;
  address: string;
  locations: Location[];
  menu_items: MenuItem[];
};
export type Location = {
  id: number;
  status: string;
  inserted_at: string;
  updated_at: string;
  truck_id: number;
  latitude: number;
  longitude: number;
};
