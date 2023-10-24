import * as S from "./style.ts";
import { EJob } from "../../../type/job.ts";

function MyPage() {
  const name = "홍길동";
  const birthday = new Date("2022-01-01");
  const tel = "010-9999-9999";
  const job = EJob.DOCTOR;
  const department = "가정의학과";

  const formattedBirthday = `${birthday.getFullYear()}. ${
    birthday.getMonth() + 1 < 10 ? "0".concat((birthday.getMonth() + 1).toString()) : birthday.getMonth() + 1
  }. ${birthday.getDate()}.`;

  const jobDetail: string | undefined =
    department && job ? department + " " + (job ? (job === EJob.DOCTOR ? "의사" : "약사") : "") : undefined;

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
            <S.VerifiedIcon />
            전문가 인증이 완료된 사용자입니다.
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
            <S.StyledInput value={jobDetail} readOnly={true} />
          </S.InputBox>
          <S.InputBox>
            <S.StyledInputLabel>연락처</S.StyledInputLabel>
            <S.StyledInput value={tel} readOnly={true} />
          </S.InputBox>
          <S.BelongInputBox>
            <S.StyledInputLabel>소속</S.StyledInputLabel>
            <S.StyledInput value={"중앙대학교 부속병원"} readOnly={true} />
          </S.BelongInputBox>
        </S.InnerBox>
      </S.MainSection>
    </S.Outer>
  );
}

export default MyPage;
