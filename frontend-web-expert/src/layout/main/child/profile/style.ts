import styled from "styled-components";

export const ProfileImg = styled.img`
  display: inline-block;
  width: 3rem;
  height: 3rem;
  border-radius: 50%;
`;

export const ProfileText = styled.div`
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: end;
  padding: 0 1rem;
  height: 100%;
`;

export const Job = styled.span`
  font-size: 0.9rem;
  line-height: 1.2rem;
  font-weight: 600;
  color: #7c7c94;
`;

export const NameBox = styled.div`
  display: flex;
  flex-direction: row;
  color: black;
`;

export const Name = styled.span`
  font-size: 1.2rem;
  line-height: 1.8rem;
  font-weight: 600;
  margin-top: 0.2rem;
`;
