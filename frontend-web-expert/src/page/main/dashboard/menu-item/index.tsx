import { TMenuInfo } from "..";
import {
  CoomingSoonDescription,
  CoomingSoonIcon,
  CoomingSoonTitle,
  Description,
  ImgBox,
  NonLinkOuter,
  Outer,
  Title,
} from "./style";

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
        <CoomingSoonTitle>{menuInfo.title}</CoomingSoonTitle>
        <CoomingSoonDescription>{menuInfo.description}</CoomingSoonDescription>
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
