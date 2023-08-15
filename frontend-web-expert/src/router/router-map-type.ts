import { SvgIconComponent } from "@mui/icons-material";
import { ComponentType } from "react";

export type RouterType = {
  path: string;
  icon: SvgIconComponent;
  korName: string;
  engName: string;
  element: ComponentType;
};
