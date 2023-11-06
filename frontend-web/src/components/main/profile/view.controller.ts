import React, { useState } from "react";
import { useMediaQuery } from "react-responsive";
import { TProfileProps } from "@components/main/profile/props.ts";

export function useProfileViewController({ job, department, belong, name }: TProfileProps) {
  const [drawerIsOpen, setDrawerIsOpen] = useState<boolean>(false);

  const isMobile = useMediaQuery({ query: "(max-width: 480px)" });

  const alertList = [{ id: 1, title: "알림입니다.", description: "알림 기능은 추가예정입니다." }];

  const iOS = typeof navigator !== "undefined" && /iPad|iPhone|iPod/.test(navigator.userAgent);

  const toggleDrawer = (open: boolean) => (event: React.KeyboardEvent | React.MouseEvent) => {
    if (
      event &&
      event.type === "keydown" &&
      ((event as React.KeyboardEvent).key === "Tab" || (event as React.KeyboardEvent).key === "Shift")
    ) {
      return;
    }

    setDrawerIsOpen(open);
  };

  const handleLogoutClick = async () => {
    window.localStorage.clear();
  };

  const jobDetail: string | undefined = department && job ? department + " " + (job ?? "") : undefined;

  return {
    layout: { isMobile, iOS },
    data: { name, belong, job, jobDetail, alertList },
    toggleDrawer,
    handleLogoutClick,
    drawerIsOpen,
  };
}
