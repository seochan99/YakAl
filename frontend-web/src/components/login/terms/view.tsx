import * as S from "./style.ts";
import { useTermsPageViewController } from "@components/login/terms/view.controller.ts";
import { ESnackbarType } from "@type/enum/snackbar-type.ts";
import YakalSnackbar from "@components/snackbar/view.tsx";

function TermsPage() {
  const { isAgreed, onClickIsAgreed, onClickNextButton, snackbarOpen, setSnackbarOpen } = useTermsPageViewController();

  return (
    <S.OuterDiv>
      <S.TermsDiv>
        <S.TermsHeader>{"약관을 확인해주세요."}</S.TermsHeader>
        <S.TermsContentDiv>
          {`1. 개인정보의 수집 및 이용 동의서`}
          <br />
          {`- 이용자가 제공한 모든 정보는 다음의 목적을 위해 활용 하며, 하기 목적 이외의
        용도로는 사용되지 않습니다.`}
          <br />
          <br />
          {`① 개인정보 수집 항목 및 수집• 이용 목적`}
          <br />
          {`가) 수집 항목 (필수항목)`}
          <br />
          {`- 성명(국문), 주민등록번호, 주소, 전화번호(자택, 휴대전 화), 사진, 이메일, 나이. 재학정보, 병역사항, 외국어 점수, 가족관계,
        재산정도, 수상내역, 사회활동, 타 장학금 수혜현황, 요식업 종사 현황 등 지원 신청서에 기재된 정보 또는 신청자가
        제공한 정보 나) 수집 및 이용 목적`}
          <br />
          <br />
          {`② 개인정보 보유 및 이용기간`}
          <br />
          {`- 수집• 이용 동의일로부터 개인정보의 수집 • 이용목적을 달성할 때까지`}
          <br />
          <br />
          {`③ 동의거부관리`}
          <br />
          {`- 귀하께서는 본 안내에 따른 개인정보 수집, 이용에 대하 여 동의를 거부하실 권리가 있습니다.
        다만, 귀하가 개인정보의 수집/이용에 동의를 거부하시는 경우 에 장학생 선발 과정에 있어 불이익이 발생할 수 있음을 알려드립니다.`}
        </S.TermsContentDiv>
        <S.Bar />
        <S.AgreementCheckInput type="checkbox" id="agreement" checked={isAgreed} onChange={onClickIsAgreed} />
        <label htmlFor="agreement">{"개인정보 수집 및 이용 동의"}</label>
      </S.TermsDiv>
      <S.NextButton className={isAgreed ? "is-agreed" : ""} disabled={!isAgreed} onClick={onClickNextButton}>
        {"다음"}
      </S.NextButton>
      <YakalSnackbar open={snackbarOpen} setOpen={setSnackbarOpen} type={ESnackbarType.TERMS_AGREEMENT_FAILED} />
    </S.OuterDiv>
  );
}

export default TermsPage;
