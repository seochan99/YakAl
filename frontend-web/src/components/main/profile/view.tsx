import { SwipeableDrawer } from "@mui/material";
import * as S from "./style.ts";
import React from "react";

import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import LocalPharmacyIcon from "@mui/icons-material/LocalPharmacy";
import LocationOnIcon from "@mui/icons-material/LocationOn";

import CloseOutlinedIcon from "@mui/icons-material/CloseOutlined";
import { EJob } from "@type/enum/job.ts";
import { TProfileProps } from "@components/main/profile/props.ts";
import { useProfileViewController } from "@components/main/profile/view.controller.ts";

function Profile(props: TProfileProps) {
  const {
    layout: { isMobile, iOS },
    data: { name, belong, job, jobDetail, alertList },
    toggleDrawer,
    handleLogoutClick,
    drawerIsOpen,
  } = useProfileViewController(props);

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
      </S.ProfileBox>
      <SwipeableDrawer
        anchor="right"
        open={drawerIsOpen}
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
                  <S.Red>{"전문가 인증 미완료"}</S.Red>
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
                  <S.Red>{"전문가 인증 미완료"}</S.Red>
                )}
              </S.DetailBelong>
            </S.DetailProfileBox>
          </S.DrawerHeader>
          <S.Bar />
          <S.DrawerTitle>
            <S.DrawerTitleText>{"알림"}</S.DrawerTitleText>
            <S.AlertClearButton>{"모두 지우기"}</S.AlertClearButton>
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
            <S.LogoutButton onClick={handleLogoutClick}>{"로그아웃"}</S.LogoutButton>
          </S.DrawerFooter>
        </S.DetailProfile>
      </SwipeableDrawer>
    </S.Outer>
  );
}

export default React.memo(Profile);
