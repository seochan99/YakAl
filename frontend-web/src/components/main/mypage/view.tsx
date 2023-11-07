import * as S from "./style.ts";
import { getDateStringFromArray } from "@util/get-date-string-from-array.ts";
import { ExpertUserViewModel } from "@page/main/view.model.ts";

function MyPage() {
  const expertUser = ExpertUserViewModel.getExpertUser();

  if (expertUser === null) {
    return <></>;
  }

  const jobDetail: string | undefined =
    expertUser.department && expertUser.job ? expertUser.department + " " + (expertUser.job ?? "") : undefined;

  const formattedTel = expertUser.tel?.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);

  return (
    <S.Outer>
      <S.Header>
        <S.BackButton to="/expert">
          <S.BackIcon />
          {"대시보드로"}
        </S.BackButton>
      </S.Header>
      <S.MainSection>
        <S.MainHeader>
          <S.Title>{"내 정보"}</S.Title>
          <S.VerifiedText>
            {jobDetail && expertUser.belong ? (
              <>
                <S.VerifiedIcon />
                {"전문가 인증이 완료된 사용자입니다."}
              </>
            ) : (
              <>
                <S.UnverifiedIcon />
                {"전문가 인증이 안된 사용자입니다."}
              </>
            )}
          </S.VerifiedText>
        </S.MainHeader>
        <S.InnerDiv>
          <S.OneItemSpan>
            <S.NameSpan>{"성함"}</S.NameSpan>
            {expertUser.name ? <S.NormalSpan>{expertUser.name}</S.NormalSpan> : null}
          </S.OneItemSpan>
          <S.OneItemSpan>
            <S.NameSpan>{"생년월일"}</S.NameSpan>
            {expertUser.birthday ? <S.NormalSpan>{getDateStringFromArray(expertUser.birthday)}</S.NormalSpan> : null}
          </S.OneItemSpan>
          <S.OneItemSpan>
            <S.NameSpan>{"직종 및 분과"}</S.NameSpan>
            <S.NormalSpan>{jobDetail ?? "정보 없음"}</S.NormalSpan>
          </S.OneItemSpan>
          <S.OneItemSpan>
            <S.NameSpan>{"연락처"}</S.NameSpan>
            {expertUser.tel ? <S.NormalSpan>{formattedTel}</S.NormalSpan> : null}
          </S.OneItemSpan>
          <S.OneItemSpan>
            <S.NameSpan>{"소속"}</S.NameSpan>
            <S.NormalSpan>{expertUser.belong ?? "정보 없음"}</S.NormalSpan>
          </S.OneItemSpan>
        </S.InnerDiv>
      </S.MainSection>
    </S.Outer>
  );
}

export default MyPage;
