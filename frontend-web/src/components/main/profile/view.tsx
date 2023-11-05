import { SwipeableDrawer } from "@mui/material";
import * as S from "./style.ts";
import React, { useState } from "react";

import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import LocalPharmacyIcon from "@mui/icons-material/LocalPharmacy";
import LocationOnIcon from "@mui/icons-material/LocationOn";

import CloseOutlinedIcon from "@mui/icons-material/CloseOutlined";
import { useMediaQuery } from "react-responsive";
import { EJob } from "@type/job.ts";

type TProfileProps = {
  job: EJob | null;
  department: string | null;
  belong: string | null;
  name: string | null;
  imgSrc: string;
};

function Profile({ job, department, belong, name, imgSrc }: TProfileProps) {
  const [isOpen, setIsOpen] = useState<boolean>(false);

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

    setIsOpen(open);
  };

  const handleLogoutClick = async () => {
    window.localStorage.clear();
  };

  const notificationsLabel = (count: number) => {
    if (count === 0) {
      return "no notifications";
    }
    if (count > 99) {
      return "more than 99 notifications";
    }
    return `${count} notifications`;
  };

  const jobDetail: string | undefined =
    department && job ? department + " " + (job ? (job === EJob.DOCTOR ? "의사" : "약사") : "") : undefined;

  return (
    <S.Outer>
      <S.ProfileBox onClick={toggleDrawer(true)}>
        {!isMobile && (
          <S.ProfileText>
            {jobDetail ? <S.Job>{jobDetail}</S.Job> : null}
            {name ? (
              <S.NameBox>
                <S.Name>{name}</S.Name>
                <S.NamePostfix>님</S.NamePostfix>
              </S.NameBox>
            ) : null}
          </S.ProfileText>
        )}
        <S.SmallBadge
          aria-label={notificationsLabel(0)}
          badgeContent={0}
          color="error"
          max={99}
          anchorOrigin={{
            vertical: "bottom",
            horizontal: "right",
          }}
        >
          <S.ProfileImg src={imgSrc} />
        </S.SmallBadge>
      </S.ProfileBox>
      <SwipeableDrawer
        anchor="right"
        open={isOpen}
        onClose={toggleDrawer(false)}
        onOpen={toggleDrawer(true)}
        disableBackdropTransition={!iOS}
        disableDiscovery={iOS}
        ModalProps={{
          keepMounted: true,
        }}
      >
        <S.DetailProfile>
          <S.DrawerHeader>
            <S.DetailProfileBox>
              {name ? (
                <S.DetailNameBox>
                  <S.DetailNamePrefix>{"안녕하세요."}</S.DetailNamePrefix>
                  <S.DetailName>{name.length > 4 ? name.slice(0, 4).concat("...") : name}</S.DetailName>
                  <S.DetailNamePostfix>{"님"}</S.DetailNamePostfix>
                </S.DetailNameBox>
              ) : null}
              <S.DetailJob>
                {job ? job === EJob.DOCTOR ? <LocalHospitalIcon /> : <LocalPharmacyIcon /> : <LocalHospitalIcon />}
                {jobDetail ? (
                  jobDetail.replace(" ", "").length > 12 ? (
                    jobDetail.slice(0, 12).concat("...")
                  ) : (
                    jobDetail
                  )
                ) : (
                  <S.Red>전문가 인증 미완료</S.Red>
                )}
              </S.DetailJob>
              <S.DetailBelong>
                <LocationOnIcon />
                {belong ? (
                  belong.replace(" ", "").length > 12 ? (
                    belong.slice(0, 12).concat("...")
                  ) : (
                    belong
                  )
                ) : (
                  <S.Red>전문가 인증 미완료</S.Red>
                )}
              </S.DetailBelong>
            </S.DetailProfileBox>
            <S.DrawerProfileImg src={imgSrc} />
          </S.DrawerHeader>
          <S.Bar />
          <S.DrawerTitle>
            <S.DrawerTitleText>알림</S.DrawerTitleText>
            <S.AlertClearButton>모두 지우기</S.AlertClearButton>
          </S.DrawerTitle>
          <S.AlertBox>
            {alertList.map((alert) => (
              <S.AlertItem key={alert.id}>
                <S.AlertTitle>{alert.title}</S.AlertTitle>
                <S.AlertDescription>{alert.description}</S.AlertDescription>
                <CloseOutlinedIcon onClick={() => console.log("1")} />
              </S.AlertItem>
            ))}
          </S.AlertBox>
          <S.Bar />
          <S.DrawerFooter>
            <S.LogoutButton onClick={handleLogoutClick}>로그아웃</S.LogoutButton>
          </S.DrawerFooter>
        </S.DetailProfile>
      </SwipeableDrawer>
    </S.Outer>
  );
}

export default React.memo(Profile);
