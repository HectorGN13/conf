mensaje_n()
{
    echo -n "\033[1;28m#\033[0m\033[36m $1\033[0m"
}

mensaje()
{
    mensaje_n "$1"
    echo
}

mensaje_error()
{
    echo "\033[1;28m#\033[0m\033[31m $1\033[0m"
}

# $1 = Variable en la que guardar el resultado
# $2 = Pregunta
# $3 = Valor por defecto (S o N)
# $4 = Si vale "-q", se salta la pregunta y devuelve el valor por defecto
pregunta()
{
    local _SN
    if [ -n "$4" ]
    then
        _SN="$3"
    else
        echo -n "\033[1;28m*\033[0m\033[34m $2 \033[0m"
        [ "$3" = "S" ] && echo -n "(S/n): " || echo -n "(s/N): "
        read _SN
        _SN=$(echo "$_SN" | tr '[:lower:]' '[:upper:]')
        if [ "$3" = "S" ]
        then
            [ "$_SN" != "N" ] && _SN="S"
        else # "$3" = "N"
            [ "$_SN" != "S" ] && _SN="N"
        fi
    fi
    eval "$1=$_SN"
}

asegura_salto_linea()
{
    if [ "`tail -c1 $1`" != "" ]
    then
        echo "" >> $1
    fi
}

desactiva_sudo()
{
    local L="%sudo	ALL=!$1"
    local F=/etc/sudoers.d/$(echo $1 | tr "/" "-" | cut -c2-)
    if [ ! -f "$F" ]
    then
        mensaje "Desactivando el uso de $1 con sudo..."
        echo "$L" | sudo tee $F > /dev/null
        sudo chmod 440 $F
    else
        mensaje "Uso de $1 con sudo ya desactivado."
    fi
}

git_user()
{
    if [ -n "$2" ]
    then
        git config --global user.$1 "$2"
    else
        echo $(git config --global user.$1)
    fi

}

github()
{
    if [ -n "$2" ]
    then
        git config --global github.$1 "$2"
    else
        echo $(git config --global github.$1)
    fi

}

token_composer()
{
    if [ -n "$1" ]
    then
        composer config -g github-oauth.github.com $1
    else
        echo $(composer config -g github-oauth.github.com 2>/dev/null)
    fi
}

activa_modulo_apache()
{
    if ! a2query -q -m $1
    then
        mensaje "Activando módulo $1 de Apache2..."
        sudo a2enmod $1
    else
        mensaje "Módulo $1 de Apache2 ya activado."
    fi
}

desactiva_xdebug()
{
    if phpquery -q -v $1 -s $2 -m xdebug
    then
        mensaje "Desactivando módulo xdebug de PHP para el SAPI $2..."
        sudo phpdismod -v $1 -s $2 xdebug
    else
        mensaje "Módulo xdebug de PHP ya desactivado para el SAPI $2."
    fi
}

activa_xdebug()
{
    if phpquery -q -v $1 -s $2 -m xdebug
    then
        mensaje "Módulo xdebug de PHP ya activado para el SAPI $2."
    else
        mensaje "Activando módulo xdebug de PHP para el SAPI $2..."
        sudo phpenmod -v $1 -s $2 xdebug
    fi
}

activa_xdebug_remoto()
{
    mensaje "Activando depuración remota con xdebug..."
    local RES="zend_extension=xdebug.so"
    RES="$RES\nxdebug.remote_enable = 1"
    RES="$RES\nxdebug.remote_autostart = 1"
    echo $RES | sudo tee /etc/php/$1/mods-available/xdebug.ini > /dev/null
}

asigna_param_php()
{
    # $1: param
    # $2: valor
    # $3: archivo
    PARAM="$1 = $2"
    if ! grep -qs "^$PARAM$" $3
    then
        mensaje "Estableciendo $PARAM en $3..."
        sudo sed -r -i "s/^;?\s*$1\s*=.*$/$PARAM/" $3
    else
        mensaje "Parámetro $PARAM ya establecido en $3."
    fi
}

asigna_param_postgresql()
{
    # $1: param
    # $2: valor
    # $3: archivo
    PARAM="$1 = $2"
    if ! grep -qs "^$PARAM" $3
    then
        mensaje "Estableciendo $PARAM..."
        sudo sed -r -i "s/^\s*#?$1\s*=/$PARAM #/" $3
    else
        mensaje "Parámetro $PARAM ya establecido."
    fi
}

comprueba_atom()
{
    if [ -z "$(which atom)" ]
    then
        mensaje_error "Atom no está instalado. Instálalo antes de continuar."
        exit 1
    else
        mensaje "Atom ya instalado."
    fi
}

comprueba_php()
{
    local CALLA=$1

    while true
    do
        if [ -z "$(which php)" ]
        then
            mensaje "PHP no está instalado."
            mensaje "Ejecuta el script php-install.sh antes de continuar."
            pregunta SN "¿Quieres hacerlo ahora? (s/N):" N $CALLA
            if [ "$SN" = "S" ]
            then
                $BASE_DIR/php-install.sh
            else
                mensaje_error "Imposible continuar. Vuelve cuando hayas ejecutado el script php-install.sh"
                exit 1
            fi
        else
            mensaje "PHP ya instalado."
            break
        fi
    done
}

comprueba_composer()
{
    local CALLA=$1

    while true
    do
        if [ -z "$(which composer)" ]
        then
            mensaje "Composer no está instalado."
            mensaje "Ejecuta el script composer-install.sh antes de continuar."
            pregunta SN "¿Quieres hacerlo ahora?" N $CALLA
            if [ "$SN" = "S" ]
            then
                $BASE_DIR/composer-install.sh
            else
                mensaje_error "Imposible continuar. Vuelve cuando hayas ejecutado el script composer-install.sh"
                exit 1
            fi
        else
            mensaje "Composer ya instalado."
            break
        fi
    done
}
