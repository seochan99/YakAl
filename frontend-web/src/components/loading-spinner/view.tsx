import * as S from "./style.ts";

function LoadingSpinner() {
  return (
    <S.OuterDiv>
      <S.SpinnerImg src={"/assets/icons/spinner-icon.gif"} alt={"loading-spinner-animation"} />
    </S.OuterDiv>
  );
}

export default LoadingSpinner;
