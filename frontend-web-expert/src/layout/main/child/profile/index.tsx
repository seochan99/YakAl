import { Job, Name, NameBox, ProfileImg, ProfileText } from "./style";

type TProfileProps = {
  job: string;
  name: string;
  imgSrc: string;
};

function Profile({ job, name, imgSrc }: TProfileProps) {
  return (
    <>
      <ProfileText>
        <Job>{job}</Job>
        <NameBox>
          <Name>{name}</Name>
        </NameBox>
      </ProfileText>
      <ProfileImg src={imgSrc} />
    </>
  );
}

export default Profile;
