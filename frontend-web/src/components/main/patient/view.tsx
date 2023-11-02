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
import Skeleton from "@mui/material/Skeleton";
import { convertRemToPixels } from "@util/rem-to-px.ts";

function PatientPage() {
  const {
    patientInfo,
    tab: { currentTab, tabInfos, onClickTab },
  } = usePatientPageViewController();

  const { base, protector } = patientInfo;

  return (
    <S.OuterDiv>
      <S.HeaderDiv>
        <S.BackLink to="/expert/patient">
          <S.StyledLinkIconSvg />
          {"환자 목록으로"}
        </S.BackLink>
        {base === null ? (
          <Skeleton variant="rounded" width={convertRemToPixels(30)} height={convertRemToPixels(6)} />
        ) : (
          <S.BaseInfoDiv>
            <S.SelfBaseTitle>
              <span>{"본인"}</span>
            </S.SelfBaseTitle>
            <S.PatientImg src={base.profileImg === "" ? "/assets/icons/no-profile-icon.png" : base.profileImg} />
            <S.InfoTextDiv>
              <S.NameSexBirthDiv>
                <S.NameSpan>
                  {base.name.substring(0, 4)}
                  {base.name.length > 4 ? "..." : ""}
                </S.NameSpan>
                <S.IconContainedSpan>
                  {`${base.birthday[0]}. ${base.birthday[1] < 10 ? "0" : ""}${base.birthday[1]}. ${
                    base.birthday[2] < 10 ? "0" : ""
                  }${base.birthday[2]}.`}
                  {`(${getAge(new Date(base.birthday[0], base.birthday[1] - 1, base.birthday[2]))}세)`}
                </S.IconContainedSpan>
                <S.IconContainedSpan>
                  {base.sex === ESex.MALE ? "남성" : "여성"}
                  {base.sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
                </S.IconContainedSpan>
              </S.NameSexBirthDiv>
              <S.NormalSpan>{`Tel. ${base.tel}`}</S.NormalSpan>
            </S.InfoTextDiv>
          </S.BaseInfoDiv>
        )}
        {protector === null ? (
          <Skeleton variant="rounded" width={convertRemToPixels(30)} height={convertRemToPixels(6)} />
        ) : protector.name === "" && protector.tel === "" ? (
          <S.BaseInfoDiv>
            <S.CenterDiv>{"보호자가 존재하지 않습니다."}</S.CenterDiv>
          </S.BaseInfoDiv>
        ) : (
          <S.BaseInfoDiv>
            <S.SelfBaseTitle>
              <span>{"보호자"}</span>
            </S.SelfBaseTitle>
            <S.InfoTextDiv>
              <S.NameSexBirthDiv>
                <S.NameSpan>
                  {protector.name.substring(0, 4)}
                  {protector.name.length > 4 ? "..." : ""}
                </S.NameSpan>
              </S.NameSexBirthDiv>
              <S.NormalSpan>{`Tel. ${protector.tel}`}</S.NormalSpan>
            </S.InfoTextDiv>
          </S.BaseInfoDiv>
        )}
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
