import { ReactNode } from "react";
import {
  EnrollBox,
  EnrollText,
  IconText,
  YakAlIcon,
  EnrollButton,
  DoctorIcon,
  CertTextBox,
  SubEnrollText,
  Blue,
  Outer,
  Menu,
  PatientIcon,
} from "./style";
import DashboardMenuItem from "./menu-item";
import { useGetUserQuery } from "@/api/user";

export type TMenuInfo = {
  path?: string;
  icon?: ReactNode;
  title: string;
  description: ReactNode;
};

function Dashboard() {
  const { data } = useGetUserQuery(null);

  const menuInfos: TMenuInfo[] = [
    {
      path: "/patient",
      icon: <PatientIcon />,
      title: "환자 정보",
      description: (
        <span>
          <Blue>{data?.name}</Blue>님께 테스트 결과를 보냈거나 상담을 요청한 환자들의 정보를 열람합니다.
        </span>
      ),
    },
    {
      title: "출시 예정",
      description: "앞으로 유용한 기능들이 추가될 예정입니다!",
    },
  ];

  return (
    <Outer>
      <EnrollBox>
        <IconText>
          <YakAlIcon />
          <EnrollText>
            약국이나 병원을 <Blue>약 알</Blue>에 등록합니다.
          </EnrollText>
        </IconText>
        <EnrollButton to="/registration">기관 등록</EnrollButton>
      </EnrollBox>
      <EnrollBox>
        <IconText>
          <DoctorIcon />
          <CertTextBox>
            <EnrollText>서비스를 이용하려면 전문가 인증이 필요합니다.</EnrollText>
            <SubEnrollText>
              <Blue>약 알</Blue>에 등록된 기관의 전문가만 인증이 가능합니다.
            </SubEnrollText>
          </CertTextBox>
        </IconText>
        <EnrollButton to="/certification">인증하기</EnrollButton>
      </EnrollBox>
      <Menu>
        {menuInfos.map((menuInfo) => (
          <DashboardMenuItem menuInfo={menuInfo} />
        ))}
      </Menu>
    </Outer>
  );
}

export default Dashboard;
