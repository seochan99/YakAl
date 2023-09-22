import { TFacility } from "../.";
import { DummyOuter, Outer } from "./style.ts";
import { EFacility } from "/src/expert/type/facility.ts";
import {
  DirectorName,
  DirectorPhone,
  FacilityType,
  Name,
  RequestedAt,
} from "/src/admin/page/main/register-list/style.ts";

import LocalHospitalOutlinedIcon from "@mui/icons-material/LocalHospitalOutlined";
import LocalPharmacyOutlinedIcon from "@mui/icons-material/LocalPharmacyOutlined";

type TFacilityItemProps = {
  facility?: TFacility;
};

function FacilityItem({ facility }: TFacilityItemProps) {
  if (!facility) {
    return <DummyOuter />;
  }

  const { id, type, directorPhone, directorName, name, requested_at } = facility;

  return (
    <Outer to={`/admin/partner/facility-registration/${id}`}>
      <FacilityType>
        {type === EFacility.HOSPITAL ? (
          <>
            <LocalHospitalOutlinedIcon />
            <span>병원</span>
          </>
        ) : (
          <>
            <LocalPharmacyOutlinedIcon />
            <span>약국</span>
          </>
        )}
      </FacilityType>
      <DirectorName>{directorName}</DirectorName>
      <DirectorPhone>{directorPhone}</DirectorPhone>
      <Name>{name}</Name>
      <RequestedAt>
        {`${requested_at.getFullYear()}. ${
          requested_at.getMonth() + 1 < 10
            ? "0".concat((requested_at.getMonth() + 1).toString())
            : requested_at.getMonth() + 1
        }. ${requested_at.getDate() < 10 ? "0".concat(requested_at.getDate().toString()) : requested_at.getDate()}.`}
      </RequestedAt>
    </Outer>
  );
}

export default FacilityItem;
