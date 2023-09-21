import { SwipeableDrawer } from "@mui/material";
import {
  AlertBox,
  AlertClearButton,
  AlertDescription,
  AlertItem,
  AlertTitle,
  Bar,
  DetailBelong,
  DetailJob,
  DetailName,
  DetailNameBox,
  DetailNamePostfix,
  DetailNamePrefix,
  DetailProfile,
  DetailProfileBox,
  DrawerFooter,
  DrawerHeader,
  DrawerProfileImg,
  DrawerTitle,
  DrawerTitleText,
  Job,
  LogoutButton,
  Name,
  NameBox,
  NamePostfix,
  Outer,
  ProfileBox,
  ProfileImg,
  ProfileText,
  Red,
  SmallBadge,
} from "./style.ts";
import React, { useState } from "react";

import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import LocalPharmacyIcon from "@mui/icons-material/LocalPharmacy";
import LocationOnIcon from "@mui/icons-material/LocationOn";

import CloseOutlinedIcon from "@mui/icons-material/CloseOutlined";
import { useMediaQuery } from "react-responsive";
import { EJob } from "../../../../type/job.ts";

type TProfileProps = {
  job?: EJob;
  department?: string;
  belong?: string;
  name: string;
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
    <Outer>
      <ProfileBox onClick={toggleDrawer(true)}>
        {!isMobile && (
          <ProfileText>
            {jobDetail ? <Job>{jobDetail}</Job> : null}
            <NameBox>
              <Name>{name}</Name>
              <NamePostfix>님</NamePostfix>
            </NameBox>
          </ProfileText>
        )}
        <SmallBadge
          aria-label={notificationsLabel(0)}
          badgeContent={0}
          color="error"
          max={99}
          anchorOrigin={{
            vertical: "bottom",
            horizontal: "right",
          }}
        >
          <ProfileImg src={imgSrc} />
        </SmallBadge>
      </ProfileBox>
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
        <DetailProfile>
          <DrawerHeader>
            <DetailProfileBox>
              <DetailNameBox>
                <DetailNamePrefix>{"안녕하세요."}</DetailNamePrefix>
                <DetailName>{name.length > 4 ? name.slice(0, 4).concat("...") : name}</DetailName>
                <DetailNamePostfix>{"님"}</DetailNamePostfix>
              </DetailNameBox>
              <DetailJob>
                {job === EJob.DOCTOR ? <LocalHospitalIcon /> : <LocalPharmacyIcon />}
                {jobDetail ? (
                  jobDetail.replace(" ", "").length > 12 ? (
                    jobDetail.slice(0, 12).concat("...")
                  ) : (
                    jobDetail
                  )
                ) : (
                  <Red>전문가 인증 미완료</Red>
                )}
              </DetailJob>
              <DetailBelong>
                <LocationOnIcon />
                {belong ? (
                  belong.replace(" ", "").length > 12 ? (
                    belong.slice(0, 12).concat("...")
                  ) : (
                    belong
                  )
                ) : (
                  <Red>전문가 인증 미완료</Red>
                )}
              </DetailBelong>
            </DetailProfileBox>
            <DrawerProfileImg src={imgSrc} />
          </DrawerHeader>
          <Bar />
          <DrawerTitle>
            <DrawerTitleText>알림</DrawerTitleText>
            <AlertClearButton>모두 지우기</AlertClearButton>
          </DrawerTitle>
          <AlertBox>
            {alertList.map((alert) => (
              <AlertItem key={alert.id}>
                <AlertTitle>{alert.title}</AlertTitle>
                <AlertDescription>{alert.description}</AlertDescription>
                <CloseOutlinedIcon onClick={() => console.log("1")} />
              </AlertItem>
            ))}
          </AlertBox>
          <Bar />
          <DrawerFooter>
            <LogoutButton onClick={handleLogoutClick}>로그아웃</LogoutButton>
          </DrawerFooter>
        </DetailProfile>
      </SwipeableDrawer>
    </Outer>
  );
}

export default Profile;
