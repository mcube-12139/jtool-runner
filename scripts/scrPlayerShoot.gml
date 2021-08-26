if (instance_number(objBullet) < 4)
{
    var bulletY = y - (global.grav * 2);
    if (global.dotkid) {
        bulletY += 8 * global.grav;
    }
    instance_create(x,bulletY,objBullet);
    audio_play_sound(sndShoot,0,false);
}
