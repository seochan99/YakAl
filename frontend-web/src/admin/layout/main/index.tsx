import {
  Bar,
  Detail,
  DrawerBox,
  DrawerFooter,
  DrawerHeader,
  DrawerSubtitle,
  DrawerTitle,
  HamburgerWrapper,
  HeaderOuter,
  LinkLogo,
  List,
  ListItem,
  ListItemSubtitle,
  LogoText,
  LogoutButton,
  MainSection,
  Outer,
  PrimarySpan,
  StyledDrawer,
  Subtitle,
  Title,
  YakalIcon,
} from "/src//admin/layout/main/style.ts";
import Footer from "/src/admin/layout/footer";
import { Outlet, useNavigation } from "react-router-dom";
import { useState } from "react";
import { Spin as Hamburger } from "hamburger-react";

import HomeOutlinedIcon from "@mui/icons-material/HomeOutlined";
import PersonOutlinedIcon from "@mui/icons-material/PersonOutlined";
import InsightsOutlinedIcon from "@mui/icons-material/InsightsOutlined";
import ManageAccountsOutlinedIcon from "@mui/icons-material/ManageAccountsOutlined";
import MedicationLiquidOutlinedIcon from "@mui/icons-material/MedicationLiquidOutlined";
import CampaignOutlinedIcon from "@mui/icons-material/CampaignOutlined";
import NotificationsOutlinedIcon from "@mui/icons-material/NotificationsOutlined";
import EditNotificationsOutlinedIcon from "@mui/icons-material/EditNotificationsOutlined";
import DocumentScannerOutlinedIcon from "@mui/icons-material/DocumentScannerOutlined";
import ManageHistoryOutlinedIcon from "@mui/icons-material/ManageHistoryOutlined";
import ForumOutlinedIcon from "@mui/icons-material/ForumOutlined";
import MedicalInformationOutlinedIcon from "@mui/icons-material/MedicalInformationOutlined";
import HandshakeOutlinedIcon from "@mui/icons-material/HandshakeOutlined";
import LocalHospitalOutlinedIcon from "@mui/icons-material/LocalHospitalOutlined";
import ApprovalOutlinedIcon from "@mui/icons-material/ApprovalOutlined";
import { SvgIconComponent } from "@mui/icons-material";
import { Tooltip } from "@mui/material";

type TSubmenu = {
  icon: SvgIconComponent;
  path: string;
  name: string;
};

type TNavList = {
  name: string;
  icon: SvgIconComponent;
  submenu: TSubmenu[];
};

export function Main() {
  const [isOpen, setIsOpen] = useState<boolean>(false);

  const navigation = useNavigation();

  const navList: TNavList[] = [
    {
      name: "사용자",
      icon: PersonOutlinedIcon,
      submenu: [
        { icon: InsightsOutlinedIcon, path: "/admin/user/statistics", name: "사용자 통계" },
        { icon: ManageAccountsOutlinedIcon, path: "/admin/user/management", name: "사용자 관리" },
      ],
    },
    {
      name: "복약",
      icon: MedicationLiquidOutlinedIcon,
      submenu: [{ icon: InsightsOutlinedIcon, path: "/admin/dose/statistics", name: "복약 통계" }],
    },
    {
      name: "알림",
      icon: NotificationsOutlinedIcon,
      submenu: [
        { icon: EditNotificationsOutlinedIcon, path: "/admin/notification/management", name: "알림 조회" },
        { icon: CampaignOutlinedIcon, path: "/admin/notification/send", name: "알림 발송" },
      ],
    },
    {
      name: "OCR",
      icon: DocumentScannerOutlinedIcon,
      submenu: [{ icon: ManageHistoryOutlinedIcon, path: "/admin/ocr", name: "OCR 평가 및 분석" }],
    },
    {
      name: "커뮤니티",
      icon: ForumOutlinedIcon,
      submenu: [
        { icon: InsightsOutlinedIcon, path: "/admin/community/statistics", name: "커뮤니티 통계" },
        { icon: ManageAccountsOutlinedIcon, path: "/admin/community/user", name: "커뮤니티 사용자 관리" },
      ],
    },
    {
      name: "전문가",
      icon: MedicalInformationOutlinedIcon,
      submenu: [
        { icon: ManageAccountsOutlinedIcon, path: "/admin/expert/management", name: "전문가 관리" },
        { icon: ApprovalOutlinedIcon, path: "/admin/expert/certification", name: "전문가 인증 관리" },
      ],
    },
    {
      icon: HandshakeOutlinedIcon,
      name: "제휴 기관",
      submenu: [
        { icon: LocalHospitalOutlinedIcon, path: "/admin/partner/management", name: "제휴 기관 관리" },
        { icon: ApprovalOutlinedIcon, path: "/admin/partner/facility-registration", name: "제휴 신청 관리" },
      ],
    },
  ];

  return (
    <Outer>
      <HeaderOuter className={isOpen ? "open" : "close"}>
        <LinkLogo to="/admin">
          <YakalIcon />
          <LogoText>
            <Title>약 알</Title>
            <Subtitle>관리자 콘솔</Subtitle>
          </LogoText>
        </LinkLogo>
        <HamburgerWrapper>
          <Hamburger
            toggled={isOpen}
            toggle={setIsOpen}
            direction="left"
            size={1.5 * parseFloat(getComputedStyle(document.documentElement).fontSize)}
            duration={0.3}
            distance="sm"
          />
        </HamburgerWrapper>
      </HeaderOuter>
      <MainSection className={isOpen ? "open" : "close"}>
        <Detail className={navigation.state === "loading" ? "loading" : ""}>
          <Outlet />
        </Detail>
      </MainSection>
      <Footer />
      <StyledDrawer variant="permanent" anchor="right" open={isOpen}>
        <DrawerBox className={isOpen ? "open" : "close"}>
          <DrawerHeader>
            {isOpen && (
              <>
                <DrawerTitle>
                  안녕하세요. <PrimarySpan>홍길동</PrimarySpan>님!
                </DrawerTitle>
                <DrawerSubtitle>관리자</DrawerSubtitle>
              </>
            )}
          </DrawerHeader>
          {isOpen && <Bar />}
          <List className={isOpen ? "open" : "close"}>
            <ListItem to="/admin" end={true}>
              <HomeOutlinedIcon />
              {isOpen && "대시보드"}
            </ListItem>
            {navList.flatMap((navItem) => {
              return [
                <ListItemSubtitle key={navItem.name}>
                  {isOpen && <navItem.icon />}
                  {navItem.name}
                </ListItemSubtitle>,
              ].concat(
                navItem.submenu.map((submenu) =>
                  isOpen ? (
                    <ListItem to={submenu.path} key={submenu.name + "_" + submenu.path}>
                      <submenu.icon />
                      {isOpen && submenu.name}
                    </ListItem>
                  ) : (
                    <Tooltip title={submenu.name} placement="left" key={submenu.name + "_" + submenu.path}>
                      <ListItem to={submenu.path}>
                        <submenu.icon />
                        {isOpen && submenu.name}
                      </ListItem>
                    </Tooltip>
                  ),
                ),
              );
            })}
          </List>
          {isOpen && (
            <>
              <Bar />
              <DrawerFooter>
                <LogoutButton>로그아웃</LogoutButton>
              </DrawerFooter>
            </>
          )}
        </DrawerBox>
      </StyledDrawer>
    </Outer>
  );
}
