import * as S from "./style.ts";
import { usePatientPageViewController } from "./view.controller.ts";
import Summary from "./child/summary/view.tsx";
import { EPatientInfoTab } from "@type/enum/patient-info-tab.ts";
import Medication from "./child/medication/view.tsx";
import GeriatricSyndrome from "./child/geriatric-syndrome/view.tsx";
import Screening from "./child/screening/view.tsx";
import { getDateStringFromArray } from "@/util/get-date-string-from-array.ts";
import getAge from "@util/get-age.ts";
import { formatTel } from "@util/format-tel.ts";
import LoadingBarrier from "@/components/loading-barrier/view.tsx";

function PatientPage() {
  const {
    isLoading,
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
        <S.BaseInfoDiv>
          {base === null ? (
            <></>
          ) : base.name === "" ? (
            <S.CenterDiv>{"환자 정보를 받아올 수 없습니다."}</S.CenterDiv>
          ) : (
            <>
              <S.SelfBaseTitle>
                <span>{"본인"}</span>
              </S.SelfBaseTitle>
              <S.InfoTextDiv>
                <S.NameSexBirthDiv>
                  <S.NameSpan>
                    {base.name.substring(0, 4)}
                    {base.name.length > 4 ? "..." : ""}
                  </S.NameSpan>
                  <S.IconContainedSpan>
                    {getDateStringFromArray(base.birthday)}
                    {`(${getAge(new Date(base.birthday[0], base.birthday[1] - 1, base.birthday[2]))}세)`}
                  </S.IconContainedSpan>
                </S.NameSexBirthDiv>
                <S.NormalSpan>{`Tel. ${formatTel(base.tel)}`}</S.NormalSpan>
              </S.InfoTextDiv>
            </>
          )}
        </S.BaseInfoDiv>
        <S.BaseInfoDiv>
          {protector === null ? (
            <></>
          ) : protector.id === -1 ? (
            <S.CenterDiv>{"보호자 정보가 존재하지 않습니다."}</S.CenterDiv>
          ) : (
            <>
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
            </>
          )}
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
        {isLoading && <LoadingBarrier />}
      </S.BodyDiv>
    </S.OuterDiv>
  );
}

export default PatientPage;
