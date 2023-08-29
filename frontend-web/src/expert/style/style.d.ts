import "styled-components";
import { ColorsTypes, FontsTypes } from "@/expert/style/theme.ts";

declare module "styled-components" {
  export interface DefaultTheme {
    colors: ColorsTypes;
    fonts: FontsTypes;
  }
}
