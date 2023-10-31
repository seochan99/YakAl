import * as S from "./style.ts";
import { useMyPageViewController } from "@components/main/mypage/view.controller.ts";

function MyPage() {
  const { name, formattedBirthday, tel, jobDetail, belong, isLoading } = useMyPageViewController();

  if (isLoading()) {
    return <></>;
  }

  return (
    <S.Outer>
      <S.Header>
        <S.BackButton to="/expert">
          <S.BackIcon />
          대시보드로
        </S.BackButton>
      </S.Header>
      <S.MainSection>
        <S.MainHeader>
          <S.Title>내 정보</S.Title>
          <S.VerifiedText>
            {jobDetail && belong ? (
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
        <S.InnerBox>
          <S.InputBox>
            <S.StyledInputLabel>성함</S.StyledInputLabel>
            <S.StyledInput value={name} readOnly={true} />
          </S.InputBox>
          <S.InputBox>
            <S.StyledInputLabel>생년월일</S.StyledInputLabel>
            <S.StyledInput value={formattedBirthday} readOnly={true} />
          </S.InputBox>
          <S.InputBox>
            <S.StyledInputLabel>직종 및 분과</S.StyledInputLabel>
            <S.StyledInput value={jobDetail ?? "정보 없음"} readOnly={true} />
          </S.InputBox>
          <S.InputBox>
            <S.StyledInputLabel>연락처</S.StyledInputLabel>
            <S.StyledInput value={tel} readOnly={true} />
          </S.InputBox>
          <S.BelongInputBox>
            <S.StyledInputLabel>소속</S.StyledInputLabel>
            <S.StyledInput value={belong ?? "정보 없음"} readOnly={true} />
          </S.BelongInputBox>
        </S.InnerBox>
      </S.MainSection>
    </S.Outer>
  );
}

export default MyPage;
