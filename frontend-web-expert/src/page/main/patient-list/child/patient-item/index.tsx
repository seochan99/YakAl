import { ESex } from "@/type/sex";
import { Birthday, GreenIcon, IconBox, Name, Outer, RedIcon, Sex, TestProgress, TotalCount, YellowIcon } from "./style";
import getAge from "@/util/get-age";
import { TUser } from "@/store/user";

import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";

type PatientItemProps = {
  userInfo: TUser;
};

function PatientItem({ userInfo }: PatientItemProps) {
  const { id, name, sex, birthday, testProgress, doseCount } = userInfo;

  return (
    <Outer to={`/patient/${id}`}>
      <Name>{name.length > 4 ? name.substring(0, 4) + "..." : name}</Name>
      <Sex>
        {sex === ESex.MALE ? "남성" : "여성"}
        {sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
      </Sex>
      <TestProgress>{`${testProgress}%`}</TestProgress>
      <IconBox>
        <GreenIcon />
        <TotalCount>{`${doseCount.green}개`}</TotalCount>
        <YellowIcon />
        <TotalCount>{`${doseCount.yellow}개`}</TotalCount>
        <RedIcon />
        <TotalCount>{`${doseCount.red}개`}</TotalCount>
      </IconBox>
      <Birthday>
        {`${birthday.getFullYear()}.
          ${birthday.getMonth() + 1}.
          ${birthday.getDate()}.
          (${getAge(birthday)}세)`}
      </Birthday>
    </Outer>
  );
}

export default PatientItem;
