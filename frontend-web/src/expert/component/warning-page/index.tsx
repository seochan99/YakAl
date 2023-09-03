import { ReactNode } from "react";
import { Icon, Text, Outer, Header, Description, Content } from "./style.ts";
import { useMediaQuery } from "react-responsive";

type TWarningPageProps = {
  children?: ReactNode;
  icon: string;
  title: string;
  subtitle?: string;
  description?: ReactNode;
};

function WarningPage({ children, icon, title, subtitle, description }: TWarningPageProps) {
  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  return (
    <Outer>
      {!isWideMobile && <Icon>{icon}</Icon>}
      <Text>
        {isWideMobile && <Icon>{icon}</Icon>}
        <Header>{title}</Header>
        {subtitle && <Description>{subtitle}</Description>}
        {description && <Content>{description}</Content>}
        {children}
      </Text>
    </Outer>
  );
}

export default WarningPage;
