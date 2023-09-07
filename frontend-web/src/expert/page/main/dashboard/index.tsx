import { ReactNode } from "react";
import {
  Blue,
  CertTextBox,
  DoctorIcon,
  EnrollBox,
  EnrollButton,
  EnrollText,
  IconText,
  Menu,
  Outer,
  PatientIcon,
  SubEnrollText,
  YakAlIcon,
} from "./style.ts";
import DashboardMenuItem from "./menu-item";
import { useMediaQuery } from "react-responsive";
import { useGetUserQuery } from "../../../api/user.ts";
import LoadingPage from "../../../../expert/page/loading-page";
import ErrorPage from "../../../../expert/page/error-page";

export type TMenuInfo = {
  path?: string;
  icon?: ReactNode;
  title: string;
  description: ReactNode;
};

export function Dashboard() {
  const { data, isLoading, isError } = useGetUserQuery(null);

  const isNarrowMobile = useMediaQuery({ query: "(max-width: 480px)" });

  const menuInfos: TMenuInfo[] = [
    {
      path: "/expert/patient",
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

  if (isLoading) {
    return <LoadingPage />;
  }

  if (isError) {
    return <ErrorPage />;
  }

  return (
    <Outer>
      <EnrollBox>
        <IconText>
          <DoctorIcon />
          <CertTextBox>
            <EnrollText>
              {"서비스를 이용하려면"}
              {isNarrowMobile ? <br /> : " "}
              {"전문가 인증이 필요합니다."}
            </EnrollText>
            <SubEnrollText>
              <Blue>{"약 알"}</Blue>
              {"에 등록된 기관의"}
              {isNarrowMobile ? <br /> : " "}
              {"전문가만 인증이 가능합니다."}
            </SubEnrollText>
          </CertTextBox>
        </IconText>
        <EnrollButton to="/expert/certification">인증하기</EnrollButton>
      </EnrollBox>
      <Menu>
        {menuInfos.map((menuInfo) => (
          <DashboardMenuItem key={menuInfo.title} menuInfo={menuInfo} />
        ))}
      </Menu>
      <EnrollBox>
        <IconText>
          <YakAlIcon />
          <EnrollText>
            약국이나 병원을 <Blue>약 알</Blue>에 등록합니다.
          </EnrollText>
        </IconText>
        <EnrollButton to="/expert/registration">기관 등록</EnrollButton>
      </EnrollBox>
    </Outer>
  );
}
