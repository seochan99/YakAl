import { ReactNode } from "react";
import * as S from "./style.ts";
import { useMediaQuery } from "react-responsive";

type TWarningPageProps = {
  children?: ReactNode;
  icon: string;
  title: string;
  subtitle?: string;
  description?: ReactNode;
};

function WarningPage(props: TWarningPageProps) {
  const { children, icon, title, subtitle, description } = props;

  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  if (isWideMobile) {
    return (
      <S.Outer>
        <S.Text>
          <S.Icon>{icon}</S.Icon>
          <S.Header>{title}</S.Header>
          {subtitle && <S.Description>{subtitle}</S.Description>}
          {description && <S.Content>{description}</S.Content>}
          {children}
        </S.Text>
      </S.Outer>
    );
  }

  return (
    <S.Outer>
      <S.Icon>{icon}</S.Icon>
      <S.Text>
        <S.Header>{title}</S.Header>
        {subtitle && <S.Description>{subtitle}</S.Description>}
        {description && <S.Content>{description}</S.Content>}
        {children}
      </S.Text>
    </S.Outer>
  );
}

export default WarningPage;
