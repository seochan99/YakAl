import styled from "styled-components";

export const Header = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
`;

export const Title = styled.span`
  color: #151515;
  font-size: 1.25rem;
  font-weight: 600;
  line-height: 1.25rem;
`;

export const AddButton = styled.div`
  & {
    display: inline-flex;
    padding: 0.4rem 0.8rem 0.4rem 0.4rem;
    justify-content: center;
    align-items: center;
    gap: 0.2rem;
    border-radius: 1.2rem;
    width: 4.5rem;
    height: 1.2rem;
    background-color: var(--color-surface-900);
    color: #151515;
    font-family: Pretendard;
    font-size: 0.9rem;
    font-weight: 600;
    line-height: 0.9rem;
    text-decoration: none;
  }

  & svg {
    height: 1.2rem;
  }

  &:hover {
    cursor: pointer;
    background-color: #e0dfe6;
  }

  &:active {
    background-color: #cbcbd6;
  }
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.125rem;
  background: var(--color-surface-900);
  margin: 1rem 0;
`;

export const List = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
  gap: 0.5rem;
`;

export const ListHeader = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  padding: 0.5rem;
  border-radius: 0.25rem;
`;

export const Item = styled.div`
  & {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    padding: 1rem 0.5rem;
    border-radius: 0.25rem;
  }

  &:hover {
    cursor: pointer;
    background-color: #f5f5f9;
  }

  &:active {
    background-color: var(--color-surface-900);
  }
`;

export const TitleHeader = styled.span`
  text-align: left;
  font-size: 1.1rem;
  line-height: 1.1rem;
  font-weight: 600;
  color: #151515;
  width: 12rem;
`;

export const RecordedDateHeader = styled.span`
  text-align: left;
  font-size: 1rem;
  line-height: 1rem;
  font-weight: 500;
  color: #90909f;
  width: 7rem;
`;

export const ItemTitle = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  text-align: left;
  width: 12rem;
`;

export const ItemRecordedDate = styled.span`
  color: #90909f;
  font-size: 0.9rem;
  font-weight: 400;
  line-height: 0.9rem;
  text-align: left;
  width: 7rem;
`;

export const DialogBox = styled.div`
  display: flex;
  flex-direction: column;

  @media only screen and (min-width: 600px) {
    padding: 1.5rem;
    width: 24rem;
  }

  @media only screen and (max-width: 599px) {
    padding: 2rem;
    justify-content: center;
    height: 100vh;
    height: -webkit-fill-available;
    height: fill-available;
  }
`;

export const DialogHeader = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
`;

export const DialogTitle = styled.span`
  font-weight: 600;

  @media only screen and (min-width: 600px) {
    font-size: 1.2rem;
    line-height: 1.2rem;
  }

  @media only screen and (max-width: 599px) {
    font-size: 1.6rem;
    line-height: 1.6rem;
  }
`;

export const DialogRecordDate = styled.span`
  font-weight: 500;
  color: #90909f;

  @media only screen and (min-width: 600px) {
    font-size: 0.9rem;
    line-height: 0.9rem;
  }

  @media only screen and (max-width: 599px) {
    font-size: 1.2rem;
    line-height: 1.2rem;
  }
`;

export const DialogInputBox = styled.div`
  display: flex;
  flex-direction: column;

  @media only screen and (min-width: 600px) {
    gap: 0.8rem;
  }

  @media only screen and (max-width: 599px) {
    gap: 1.2rem;
    flex: 1;
  }
`;

export const Label = styled.span`
  margin-left: 0.2rem;
  font-weight: 500;
  color: #90909f;

  @media only screen and (min-width: 600px) {
    font-size: 0.9rem;
    line-height: 0.9rem;
  }

  @media only screen and (max-width: 599px) {
    font-size: 1.2rem;
    line-height: 1.2rem;
  }
`;

export const NoteTitleInput = styled.input`
  & {
    color: #151515;
    text-align: left;
    font-weight: 500;
    border: 0.125rem solid var(--color-surface-900);
    border-radius: 0.25rem;
    outline: none;

    @media only screen and (min-width: 600px) {
      padding: 0.6rem;
      font-size: 1rem;
      line-height: 1rem;
    }

    @media only screen and (max-width: 599px) {
      padding: 0.9rem;
      font-size: 1.2rem;
      line-height: 1.2rem;
    }
  }

  &:focus {
    border: 0.15rem solid #2666f6;
    transition: all 0.2s;
  }
`;

export const NoteDescriptionInput = styled.textarea`
  & {
    color: #151515;
    text-align: left;
    font-weight: 500;
    border: 0.125rem solid var(--color-surface-900);
    border-radius: 0.25rem;
    outline: none;
    resize: none;

    @media only screen and (min-width: 600px) {
      padding: 0.6rem;
      font-size: 1rem;
      line-height: 1.4rem;
      height: 7rem;
    }

    @media only screen and (max-width: 599px) {
      padding: 0.9rem;
      font-size: 1.2rem;
      line-height: 1.8rem;
      flex: 1;
    }
  }

  &:focus {
    border: 0.15rem solid #2666f6;
    transition: all 0.3s;
  }
`;

export const DialogFooter = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: end;
  align-items: center;
  margin-top: 1rem;
  gap: 1rem;

  @media only screen and (min-width: 600px) {
    justify-content: end;
  }

  @media only screen and (max-width: 599px) {
    justify-content: space-between;
  }
`;

export const DialogDeleteButton = styled.button`
  & {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    border: 0;
    border-radius: 0.5rem;
    background-color: #c61a24;
    color: #fff;
    font-weight: 600;
    text-decoration: none;
    justify-self: start;

    @media only screen and (min-width: 600px) {
      font-size: 1rem;
      line-height: 1rem;
      padding: 0.6rem 1.2rem;
    }

    @media only screen and (max-width: 599px) {
      font-size: 1.2rem;
      line-height: 1.2rem;
      padding: 1rem 0;
      flex: 1;
    }
  }

  &:hover {
    cursor: pointer;
    background-color: #fef4f5;
  }

  &:active {
    background-color: #f7d1d1;
  }
`;

export const DialogCancelButton = styled.button`
  & {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    border: 0.1rem solid #c61a24;
    border-radius: 0.5rem;
    background-color: #fff;
    color: #c61a24;
    font-weight: 600;
    text-decoration: none;

    @media only screen and (min-width: 600px) {
      font-size: 1rem;
      line-height: 1rem;
      padding: 0.6rem 1.2rem;
    }

    @media only screen and (max-width: 599px) {
      font-size: 1.2rem;
      line-height: 1.2rem;
      padding: 1rem 0;
      flex: 1;
    }
  }

  &:hover {
    cursor: pointer;
    background-color: #fef4f5;
  }

  &:active {
    background-color: #f7d1d1;
  }
`;

export const DialogConfirmButton = styled.button`
  & {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    border: 0.1rem solid #2666f6;
    border-radius: 0.5rem;
    background-color: #2666f6;
    color: #fff;
    font-weight: 600;
    text-decoration: none;

    @media only screen and (min-width: 600px) {
      font-size: 1rem;
      line-height: 1rem;
      padding: 0.6rem 1.2rem;
    }

    @media only screen and (max-width: 599px) {
      font-size: 1.2rem;
      line-height: 1.2rem;
      padding: 1rem 0;
      flex: 1;
    }
  }

  &:hover {
    cursor: pointer;
    border: 0.1rem solid #1348e2;
    background-color: #1348e2;
  }

  &:active {
    border: 0.1rem solid #163bb7;
    background-color: #163bb7;
  }
`;
