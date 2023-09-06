import { TFacility } from "../facility-registration-list";
import { facilityList } from "/src/expert/store/facility-list.ts";

export type TFacilityRegistrationInfoLoaderArgs = {
  facilityId: string;
};

export type TFacilityRegistrationInfoLoaderReturn = {
  facilityInfo?: TFacility;
};

export async function loader({ params }: { params: unknown }): Promise<TFacilityRegistrationInfoLoaderReturn> {
  const typesParams = params as TFacilityRegistrationInfoLoaderArgs;
  const facilityInfo = facilityList.find((facility) => facility.id === +typesParams.facilityId);
  return { facilityInfo };
}
