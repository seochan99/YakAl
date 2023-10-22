import { useState } from "react";
import { useMediaQuery } from "react-responsive";
import { useLocation } from "react-router-dom";
import { MainPageModel } from "./model.ts";

export const useMainPageViewController = () => {
  /* Mobile Nav List */
  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  const [mobileNavOpen, setMobileNavOpen] = useState<boolean>(false);

  const onClickMobileNavTitle = () => {
    setMobileNavOpen(!mobileNavOpen);
  };

  const closeMobileNavList = () => {
    setMobileNavOpen(false);
  };

  /* Current Location */
  const navList = MainPageModel.navList;
  const location = useLocation();
  const currentNavItem = navList.findLast((navItem) => location.pathname.startsWith(navItem.path));

  return {
    nav: { navList, currentNavItem },
    mobileNav: { isWideMobile, mobileNavOpen, onClickMobileNavTitle, closeMobileNavList },
  };
};
