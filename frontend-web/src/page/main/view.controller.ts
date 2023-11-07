import { useEffect, useState } from "react";
import { useMediaQuery } from "react-responsive";
import { useLocation } from "react-router-dom";
import { MainPageModel } from "@store/main-page.ts";
import { ExpertUserViewModel } from "@page/main/view.model.ts";

export const useMainPageViewController = () => {
  ExpertUserViewModel.use();

  const { fetch, getExpertUser, isLoading } = ExpertUserViewModel;
  const expertUser = getExpertUser();

  /* Mobile Nav List */
  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  const [mobileNavOpen, setMobileNavOpen] = useState<boolean>(false);

  useEffect(() => {
    fetch();
  }, [fetch]);

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
    expertUser,
    isLoading: isLoading(),
    nav: { navList, currentNavItem },
    mobileNav: { isWideMobile, mobileNavOpen, onClickMobileNavTitle, closeMobileNavList },
  };
};
