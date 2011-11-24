# $1 script
# $2 threeshold errores a permitir, opcional
$1 > script-test.log &
ERRORS_QUANT=$(grep -c FAILED script-test.log)

if[ $ERRORS_QUANT -ge $2 ]
  ERRORS_LOG
  echo "$ERRORS_QUANT errores"
elseif
  echo "0"
fi

