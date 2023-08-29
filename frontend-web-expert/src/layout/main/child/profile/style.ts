import { Badge } from "@mui/material";
import styled from "styled-components";

export const Outer = styled.div`
  position: relative;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;

  @media only screen and (min-width: 769px) {
    width: 20rem;
  }
`;

export const ProfileBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: end;
  align-items: center;
  width: 100%;
  gap: 1.5rem;
`;

export const SmallBadge = styled(Badge)`
  & .MuiBadge-badge {
    border: 0.125rem solid white;
    border-radius: 0.9rem;
    font-size: 0.9rem;
    line-height: 0.9rem;
    bottom: 0.4rem;
    right: 2.4rem;
  }
`;

export const ProfileImg = styled.img`
  & {
    display: inline-block;
    width: 4rem;
    height: 4rem;
    border-radius: 50%;
    margin-right: 2rem;
  }
  &:hover {
    cursor: pointer;
  }
`;

export const DrawerProfileImg = styled.img`
  & {
    display: inline-block;
    width: 4rem;
    height: 4rem;
    border-radius: 50%;
  }
  &:hover {
    cursor: pointer;
  }
`;

export const ProfileText = styled.div`
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: end;
  height: 100%;
  gap: 0.4rem;
`;

export const Job = styled.span`
  font-size: 1rem;
  line-height: 1.2rem;
  font-weight: 600;
  color: #7c7c94;
  width: 10rem;
  text-align: right;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
`;

export const NameBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: end;
  color: black;
  width: 10rem;
`;

export const Name = styled.span`
  font-size: 1.6rem;
  line-height: 1.6rem;
  font-weight: 600;
  text-align: right;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
`;

export const NamePostfix = styled.span`
  font-size: 1.2rem;
  line-height: 1.2rem;
  font-weight: 500;
  padding-top: 0.35rem;
  padding-left: 0.3rem;
`;

export const DetailProfile = styled.div`
  padding: 0 1.5rem;
  width: calc(20rem - 1.5rem * 2);
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: start;
  font-family: Pretendard;
  color: #151515;
`;

export const DrawerHeader = styled.div`
  padding: 1.2rem 0;
  height: calc(6.75rem - 1.2rem * 2);
  display: flex;
  flex-direction: row;
  align-items: center;
`;

export const DetailProfileBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-self: stretch;
  gap: 0.4rem;
  flex: 1;
  overflow: hidden;
  white-space: nowrap;
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.125rem;
  background: #e9e9ee;
  margin: 0;
`;

export const DetailNameBox = styled.span`
  display: flex;
  flex-direction: row;
  justify-content: start;
  margin-bottom: 0.2rem;
`;

export const DetailNamePrefix = styled.span`
  font-size: 1rem;
  line-height: 1rem;
  font-weight: 500;
  padding: 0.32rem 0.3rem 0;
`;

export const DetailName = styled.span`
  font-size: 1.3rem;
  line-height: 1.3rem;
  font-weight: 600;
`;

export const DetailNamePostfix = styled.span`
  font-size: 1rem;
  line-height: 1rem;
  font-weight: 500;
  padding-top: 0.32rem;
  padding-left: 0.3rem;
`;

export const DetailJob = styled.span`
  & {
    display: inline-block;
    display: flex;
    flex-direction: row;
    align-items: center;
    font-size: 0.9rem;
    line-height: 0.9rem;
    font-weight: 500;
    color: #7c7c94;
  }
  & svg {
    height: 0.9rem;
  }
`;

export const DetailBelong = styled.span`
  & {
    display: inline-block;
    display: flex;
    flex-direction: row;
    align-items: center;
    font-size: 0.9rem;
    line-height: 0.9rem;
    font-weight: 500;
    color: #7c7c94;
  }
  & svg {
    height: 0.9rem;
  }
`;

export const DrawerTitle = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    margin-top: 1rem;
    padding: 0 0.3rem;
  }
`;

export const DrawerTitleText = styled.span`
  font-size: 0.9rem;
  line-height: 0.9rem;
  font-weight: 500;
  font-family: Pretendard;
  color: #151515;
`;

export const AlertClearButton = styled.div`
  & {
    display: inline-flex;
    padding: 0.4rem 0.8rem;
    justify-content: center;
    align-items: center;
    border-radius: 0.5rem;
    background-color: #e9e9ee;
    color: #151515;
    font-family: Pretendard;
    font-size: 0.8rem;
    line-height: 0.8rem;
    font-weight: 500;
    text-decoration: none;
  }
  &:hover {
    cursor: pointer;
    background-color: #e0dfe6;
  }
  &:active {
    background-color: #cbcbd6;
  }
`;

export const AlertBox = styled.div`
  display: flex;
  flex-direction: column;
  padding: 0 0.3rem;
  margin: 1rem 0;
  gap: 0.8rem;
  overflow: auto;
  flex: 1;
`;

export const AlertItem = styled.div`
  & {
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: 0.4rem;
    font-size: 0.9rem;
    line-height: 0.9rem;
    font-weight: 500;
    border: 0;
    border-radius: 0.25rem;
    background-color: #f5f5f9;
    padding: 1rem;
  }
  & svg {
    position: absolute;
    top: 0.5rem;
    right: 0.5rem;
    height: 1rem;
    width: 1rem;
    padding: 0.2rem;
    background-color: #e9e9ee;
    border-radius: 1rem;
  }
`;

export const AlertTitle = styled.span`
  font-size: 0.8rem;
  line-height: 0.8rem;
  font-weight: 500;
`;

export const AlertDescription = styled.span`
  font-size: 0.8rem;
  line-height: 0.8rem;
  font-weight: 400;
`;

export const DrawerFooter = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 5rem;
`;

export const LogoutButton = styled.div`
  & {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 0.65rem 2.25rem;
    border: 0;
    border-radius: 0.25rem;
    font-size: 0.9rem;
    line-height: 0.9rem;
    font-weight: 600;
    color: #fff;
    background-color: #c61a24;
  }
  &:hover {
    background-color: #b7141f;
    cursor: pointer;
  }
  &:active {
    background-color: #cf5658;
  }
`;
