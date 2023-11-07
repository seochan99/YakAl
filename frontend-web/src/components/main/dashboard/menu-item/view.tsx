import { TMenuInfo } from "../view.tsx";
import {
  ComingSoonDescription,
  ComingSoonTitle,
  CoomingSoonIcon,
  Description,
  ImgBox,
  NonLinkOuter,
  Outer,
  Title,
} from "./style.ts";

type TDashboardMenuItemProps = {
  menuInfo: TMenuInfo;
};

function DashboardMenuItem({ menuInfo }: TDashboardMenuItemProps) {
  if (!menuInfo.path || !menuInfo.icon) {
    return (
      <NonLinkOuter>
        <ImgBox>
          <CoomingSoonIcon />
        </ImgBox>
        <ComingSoonTitle>{menuInfo.title}</ComingSoonTitle>
        <ComingSoonDescription>{menuInfo.description}</ComingSoonDescription>
      </NonLinkOuter>
    );
  }

  return (
    <Outer to={menuInfo.path}>
      <ImgBox>{menuInfo.icon}</ImgBox>
      <Title>{menuInfo.title}</Title>
      <Description>{menuInfo.description}</Description>
    </Outer>
  );
}

export default DashboardMenuItem;
