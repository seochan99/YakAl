import { ReactNode } from "react";
import * as S from "./style.ts";
import DashboardMenuItem from "./menu-item/view.tsx";
import { useMediaQuery } from "react-responsive";

export type TMenuInfo = {
  path?: string;
  icon?: ReactNode;
  title: string;
  description: ReactNode;
};

export function DashboardPage() {
  const isNarrowMobile = useMediaQuery({ query: "(max-width: 480px)" });

  const menuInfos: TMenuInfo[] = [
    {
      path: "/expert/patient",
      icon: <S.PatientIcon />,
      title: "환자 정보",
      description: (
        <span>
          <S.Blue>{"홍길동"}</S.Blue>님께 테스트 결과를 보냈거나 상담을 요청한 환자들의 정보를 열람합니다.
        </span>
      ),
    },
    {
      title: "출시 예정",
      description: "앞으로 유용한 기능들이 추가될 예정입니다!",
    },
  ];

  return (
    <S.Outer>
      <S.EnrollBox>
        <S.IconText>
          <S.DoctorIcon />
          <S.CertTextBox>
            <S.EnrollText>
              {"서비스를 이용하려면"}
              {isNarrowMobile ? <br /> : " "}
              {"전문가 인증이 필요합니다."}
            </S.EnrollText>
            <S.SubEnrollText>
              <S.Blue>{"약 알"}</S.Blue>
              {"에 등록된 기관의"}
              {isNarrowMobile ? <br /> : " "}
              {"전문가만 인증이 가능합니다."}
            </S.SubEnrollText>
          </S.CertTextBox>
        </S.IconText>
        <S.EnrollButton to="/expert/certification">인증하기</S.EnrollButton>
      </S.EnrollBox>
      <S.Menu>
        {menuInfos.map((menuInfo) => (
          <DashboardMenuItem key={menuInfo.title} menuInfo={menuInfo} />
        ))}
      </S.Menu>
      <S.EnrollBox>
        <S.IconText>
          <S.YakAlIcon />
          <S.EnrollText>
            약국이나 병원을 <S.Blue>약 알</S.Blue>에 등록합니다.
          </S.EnrollText>
        </S.IconText>
        <S.EnrollButton to="/expert/registration">기관 등록</S.EnrollButton>
      </S.EnrollBox>
    </S.Outer>
  );
}
