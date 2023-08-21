import { ESex } from "@/type/sex";
import { Birthday, Name, NameSex, Outer, Sex } from "./style";
import getAge from "@/util/get-age";

type PatientItemProps = {
  id: number;
  name: string;
  sex: ESex;
  birthday: Date;
};

function PatientItem({ id, name, sex, birthday }: PatientItemProps) {
  return (
    <Outer
      to={`/patient/${id}`}
      className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
    >
      <NameSex>
        <Name>{name.length > 4 ? name.substring(0, 4) + "..." : name}</Name>
        <Sex>{sex === ESex.MALE ? "(남성)" : "(여성)"}</Sex>
      </NameSex>
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
