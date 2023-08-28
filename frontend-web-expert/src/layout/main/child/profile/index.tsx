import { SwipeableDrawer } from "@mui/material";
import {
  AlertTitle,
  AlertBox,
  AlertItem,
  Bar,
  DetailBelong,
  DetailJob,
  DetailName,
  DetailNameBox,
  DetailNamePostfix,
  DetailNamePrefix,
  DetailProfile,
  DetailProfileBox,
  DrawerHeader,
  DrawerTitle,
  Job,
  Name,
  NameBox,
  NamePostfix,
  Outer,
  ProfileBox,
  ProfileImg,
  ProfileText,
  SmallBadge,
  AlertDescription,
  DrawerFooter,
  LogoutButton,
  DrawerProfileImg,
  AlertClearButton,
  DrawerTitleText,
} from "./style";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useLazyLogoutQuery } from "@/api/auth";
import { useDispatch } from "react-redux";

import { LOGIN_ROUTE } from "@/router/router";

import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import LocalPharmacyIcon from "@mui/icons-material/LocalPharmacy";
import LocationOnIcon from "@mui/icons-material/LocationOn";
import { EJob } from "@/type/job";
import { logout } from "@/store/auth";

import CloseOutlinedIcon from "@mui/icons-material/CloseOutlined";
import { useMediaQuery } from "react-responsive";

type TProfileProps = {
  job: string;
  name: string;
  imgSrc: string;
};

function Profile({ job, name, imgSrc }: TProfileProps) {
  const [isOpen, setIsOpen] = useState<boolean>(false);

  const [trigger, currentResult] = useLazyLogoutQuery();

  const isMobile = useMediaQuery({ query: "(max-width: 480px)" });

  const dispatch = useDispatch();
  const navigate = useNavigate();

  const jobType = EJob.DOCTOR;
  const belong = "중앙대학교 부속병원 소속";
  const alertList = [
    { id: 1, title: "알림입니다.", description: "알림입니다. 알림알림알림알림" },
    { id: 2, title: "알람입니다.", description: "알람입니다. 알림알림알림알림" },
    { id: 3, title: "알라트입니다.", description: "알림입니다. 알림알림알림알림" },
    { id: 4, title: "알라암입니다.", description: "알림입니다. 알림알림알림알림" },
    { id: 5, title: "알림입니다.", description: "알림입니다. 알림알림알림알림" },
    { id: 6, title: "알람입니다.", description: "알람입니다. 알림알림알림알림" },
    { id: 7, title: "알라트입니다.", description: "알림입니다. 알림알림알림알림" },
    { id: 8, title: "알라암입니다.", description: "알림입니다. 알림알림알림알림" },
  ];

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
    trigger(null);
  };

  useEffect(() => {
    const { isSuccess, isLoading } = currentResult;

    if (isSuccess && !isLoading) {
      dispatch(logout());
      navigate(LOGIN_ROUTE);
    }
  }, [currentResult, dispatch, navigate]);

  const notificationsLabel = (count: number) => {
    if (count === 0) {
      return "no notifications";
    }
    if (count > 99) {
      return "more than 99 notifications";
    }
    return `${count} notifications`;
  };

  return (
    <Outer>
      <ProfileBox onClick={toggleDrawer(true)}>
        {!isMobile && (
          <ProfileText>
            <Job>{job}</Job>
            <NameBox>
              <Name>{name}</Name>
              <NamePostfix>님</NamePostfix>
            </NameBox>
          </ProfileText>
        )}
        <SmallBadge
          aria-label={notificationsLabel(1)}
          badgeContent={1}
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
                {jobType === EJob.DOCTOR ? <LocalHospitalIcon /> : <LocalPharmacyIcon />}
                {job.replace(" ", "").length > 12 ? job.slice(0, 12).concat("...") : job}
              </DetailJob>
              <DetailBelong>
                <LocationOnIcon />
                {belong.replace(" ", "").length > 12 ? belong.slice(0, 12).concat("...") : belong}
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
            <LogoutButton>로그아웃</LogoutButton>
          </DrawerFooter>
        </DetailProfile>
      </SwipeableDrawer>
    </Outer>
  );
}

export default Profile;
