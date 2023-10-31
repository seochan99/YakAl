import * as S from "./style.ts";
import { usePatientPageViewController } from "./view.controller.ts";
import { ESex } from "@type/sex.ts";
import getAge from "@util/get-age.ts";
import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";
import Summary from "./child/summary/view.tsx";
import { EPatientInfoTab } from "@type/patient-info-tab.ts";
import Medication from "./child/medication/view.tsx";
import GeriatricSyndrome from "./child/geriatric-syndrome/view.tsx";
import Screening from "./child/screening/view.tsx";

function PatientPage() {
  const {
    patientInfo,
    tab: { currentTab, tabInfos, onClickTab },
  } = usePatientPageViewController();

  if (patientInfo.base === null || patientInfo.protector === null) {
    return <></>;
  }

  const {
    base: { name, profileImg, birthday, sex, tel },
    protector: { name: pName, relationship: pRelationship, tel: pTel },
  } = patientInfo;

  return (
    <S.OuterDiv>
      <S.HeaderDiv>
        <S.BackLink to="/expert/patient">
          <S.StyledLinkIconSvg />
          환자 목록으로
        </S.BackLink>
        <S.BaseInfoDiv>
          <S.SelfBaseTitle>
            <span>본인</span>
          </S.SelfBaseTitle>
          <S.PatientImg src={profileImg === "" ? "/assets/icons/no-profile-icon.png" : profileImg} />
          <S.InfoTextDiv>
            <S.NameSexBirthDiv>
              <S.NameSpan>
                {name.substring(0, 4)}
                {name.length > 4 ? "..." : ""}
              </S.NameSpan>
              <S.IconContainedSpan>
                {`${birthday[0]}. ${birthday[1] < 10 ? "0" : ""}${birthday[1]}. ${birthday[2] < 10 ? "0" : ""}${
                  birthday[2]
                }.`}
                {`(${getAge(new Date(birthday[0], birthday[1] - 1, birthday[2]))}세)`}
              </S.IconContainedSpan>
              <S.IconContainedSpan>
                {sex === ESex.MALE ? "남성" : "여성"}
                {sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
              </S.IconContainedSpan>
            </S.NameSexBirthDiv>
            <S.NormalSpan>{`Tel. ${tel}`}</S.NormalSpan>
          </S.InfoTextDiv>
        </S.BaseInfoDiv>
        <S.BaseInfoDiv>
          <S.SelfBaseTitle>
            <span>{"보호자"}</span>
          </S.SelfBaseTitle>
          <S.InfoTextDiv>
            <S.NameSexBirthDiv>
              <S.NameSpan>
                {pName.substring(0, 4)}
                {pName.length > 4 ? "..." : ""}
              </S.NameSpan>
              <S.IconContainedSpan>{`(${pRelationship})`}</S.IconContainedSpan>
            </S.NameSexBirthDiv>
            <S.NormalSpan>{`Tel. ${pTel}`}</S.NormalSpan>
          </S.InfoTextDiv>
        </S.BaseInfoDiv>
      </S.HeaderDiv>
      <S.BodyDiv>
        <S.TabBarDiv>
          {tabInfos.map((tabInfo, index) => (
            <S.TabDiv
              key={index}
              className={currentTab === index ? "selected" : "unselected"}
              onClick={onClickTab(index)}
            >
              <S.TabTitleSpan>{tabInfo.kor}</S.TabTitleSpan>
              <S.TabSubtitleSpan>{tabInfo.eng}</S.TabSubtitleSpan>
            </S.TabDiv>
          ))}
        </S.TabBarDiv>
        <S.InnerDiv>
          {currentTab === EPatientInfoTab.SUMMARY && <Summary />}
          {currentTab === EPatientInfoTab.MEDICATION && <Medication />}
          {currentTab === EPatientInfoTab.GERIATRIC_SYNDROME && <GeriatricSyndrome />}
          {currentTab === EPatientInfoTab.SCREENING && <Screening />}
        </S.InnerDiv>
      </S.BodyDiv>
    </S.OuterDiv>
  );
}

export default PatientPage;
