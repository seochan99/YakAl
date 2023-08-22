import { Tooltip, Zoom } from "@mui/material";
import { ReactElement } from "react";

type TNavbarTooltipProps = {
  children: ReactElement;
  title: string;
};

function NavbarTooltip({ children, title }: TNavbarTooltipProps) {
  return (
    <Tooltip
      title={title}
      placement="top"
      TransitionComponent={Zoom}
      PopperProps={{
        modifiers: [
          {
            name: "offset",
            options: {
              offset: [0, -10],
            },
          },
        ],
      }}
      TransitionProps={{ timeout: 100 }}
    >
      {children}
    </Tooltip>
  );
}

export default NavbarTooltip;
