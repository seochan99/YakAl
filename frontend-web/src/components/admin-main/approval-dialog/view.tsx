import * as S from "./style.ts";
import { DialogActions, DialogTitle } from "@mui/material";

type TApprovalDialog = {
  title: string;
  isOpen: boolean;
  onClose: () => void;
  onClickOkay: () => void;
  hasReasonForm: boolean;
  reason?: string;
  onChangeReason?: (event: React.ChangeEvent<HTMLTextAreaElement>) => void;
};

function ApprovalDialog({
  title,
  isOpen,
  onClose,
  onClickOkay,
} // hasReasonForm,
// reason,
// onChangeReason,
: TApprovalDialog) {
  return (
    <S.StyledDialog open={isOpen} onClose={onClose} aria-labelledby="approval-dialog">
      <DialogTitle>{title}</DialogTitle>
      {/*{hasReasonForm && (*/}
      {/*  <S.ReasonInput*/}
      {/*    rows={5}*/}
      {/*    cols={25}*/}
      {/*    maxLength={125}*/}
      {/*    value={reason}*/}
      {/*    onChange={onChangeReason}*/}
      {/*    placeholder={"승인 거절 이유(최대 125자)"}*/}
      {/*  />*/}
      {/*)}*/}
      <DialogActions>
        <S.CancelButton onClick={onClose}>{"취소"}</S.CancelButton>
        <S.OkayButton onClick={onClickOkay}>{"확인"}</S.OkayButton>
      </DialogActions>
    </S.StyledDialog>
  );
}

export default ApprovalDialog;
