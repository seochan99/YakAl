import { ReactNode } from "react";
import * as S from "./style.ts";
import { useMediaQuery } from "react-responsive";

type TWarningPageProps = {
  children?: ReactNode;
  iconPath: string;
  title: string;
  subtitle?: string;
  description?: ReactNode;
};

function WarningPage(props: TWarningPageProps) {
  const { children, iconPath, title, subtitle, description } = props;

  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  return (
    <S.OuterDiv>
      {!isWideMobile && <S.IconImg src={iconPath} />}
      <S.ContentDiv>
        {isWideMobile && <S.IconImg src={iconPath} />}
        <S.TitleSpan>{title}</S.TitleSpan>
        {subtitle && <S.SubtitleSpan>{subtitle}</S.SubtitleSpan>}
        {description && <S.DescriptionParagraph>{description}</S.DescriptionParagraph>}
        {children}
      </S.ContentDiv>
    </S.OuterDiv>
  );
}

export default WarningPage;
