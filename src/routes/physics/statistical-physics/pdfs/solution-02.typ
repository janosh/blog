#import "/notes.typ": task, unit, pd
#import "/statistical-physics/sheet.typ": points, sheet

#show: sheet.with(2, [November 11th, 2016])


= Paramagnet #points(3)

#task[
  We describe magnetic substances by the following thermodynamic variables: the temperature $T$, the magnetic field $H$, and the magnetization $M$. Show that for paramagnetic substances, for which#footnote[@eq:curie is known as Curie's law, where $C$ is a material-specific constant (not to be confused with the heat capacity).]
  $ M = C/T H, $ <eq:curie>
  the internal energy $U$ depends only on $T$.
]

The change in internal energy for a paramagnet is
$ dif U = T dif S + H dif M. $ <eq:du>
As a function $U(T, M)$, the internal energy's total differential is
$ dif U = underbrace(pd(U, T, M), C_M) dif T + pd(U, M, T) dif M. $ <eq:du-total>
Equating @eq:du and @eq:du-total and solving for $dif S$ yields
$ dif S = C_M/T dif T + 1/T (pd(U, M, T) - H) dif M. $
Since $dif S$ is exact,
$ lr(partial/(partial M) C_M/T |)_T = lr(partial/(partial T) 1/T (pd(U, M, T) - H) |)_M. $
Performing the $T$-derivative on the r.h.s.,
$ lr(cancel(partial/(partial M) C_M/T) |)_T = -1/T^2 (pd(U, M, T) - H) + cancel(1/T (partial^2 U)/(partial T partial M)) - lr(1/T (partial H)/(partial T) |)_M, $
and canceling terms leaves us with
$ pd(U, M, T) = H - T pd(H, T, M). $
Inserting @eq:curie in the form $H = T/C M$ results in
$ pd(U, M, T) = 0, $
from which we infer $U(T, M) = U(T)$.

= Heating water #points(3)

#task[
  One kilogram of water at 0~°C is put into thermal contact with a heat bath at 100~°C. What is the change in entropy of water, heat bath, and total system by the time the temperature of the water has reached 100~°C? How can one heat up the water to that temperature without changing the entropy of the total system? Use $c_p = 4180 unit("J")/(unit("kg") unit("K"))$.
]

We start with a short discussion of heat capacities. $C$ determines the amount of energy needed to bring about a certain change in temperature.

For a gas, $C_V$ is determined by the change in internal energy $U$ concurrent with a change in temperature at fixed volume, i.e. $C_V = pd(U, T, V)$, whereas $C_p$ is the change in enthalpy $H$ at fixed pressure, i.e $C_p = pd(H, T, p)$. Since $dif H = dif U + p dif V$ ($+ V dif p$, but $dif p = 0$ at constant pressure) $C_p$ is greater than $C_V$ since the volume must increase, i.e. $dif V > 0$ during a heating process if the pressure is to be kept constant. Thus heating at constant pressure requires more energy than at constant volume as some of the energy is expended towards driving the expansion.

For liquids and solids which can, to a good approximation, be assumed incompressible, $C_V$ and $C_p$ are practically identical.

Coming back to the exercise, the entropy is the integral over heat transfer divided by temperature. As long as it does not start to boil, heating a liquid involves no work. Thus, $dif U = delta Q + underbrace(delta W, 0) = delta Q$, and
$
  Delta S_(upright(H_2 O)) & = integral (delta Q)/T = integral (dif U)/T = C_V integral_(T_1)^(T_2) (dif T)/T = C_V ln(T_2/T_1) \
  & approx C_p ln(T_2/T_1) = c_p m_(upright(H_2 O)) ln(T_2/T_1) approx 1305 unit("J")/unit("K"),
$
where $c_p = 4180 unit("J")/(unit("kg") unit("K"))$ is the specific heat, i.e. heat capacity per unit mass, $m_(upright(H_2 O)) = 1 unit("kg")$ is the total mass of water, $T_1 = 273 unit("K")$, and $T_2 = 373 unit("K")$. In the case of the heat bath with constant temperature, the integral simplifies to
$ Delta S_"HB" = integral (delta Q)/T = (Delta Q_"HB")/T_"HB" = -(Delta Q_(upright(H_2 O)))/T_"HB" = -(c_p m_(upright(H_2 O)) Delta T_(upright(H_2 O)))/T_"HB" approx -1121 unit("J")/unit("K"). $
By the time the heat bath and water reach thermal equilibrium, the combined system's entropy will have increased by $Delta S_"tot" approx 184 unit("J")/unit("K")$.

Equilibrating water and heat bath without producing entropy would require an idealized Carnot engine capable of reversibly transferring heat from the bath to the water. Since such a Carnot engine cannot exist under real circumstances, this is just another way of saying that reaching equilibrium without producing entropy is impossible.

= Power station #points(2)

#task[
  A 1000~MW power plant is run at a river, the water of which is used as a coolant. The heat source in the power plant is at a temperature of 600~K, the water taken from the river is at 290~K. By how many degrees is the river heated up by the power plant if the efficiency of the plant is 50~% of the maximally possible efficiency? (Data: cross-sectional area of the river $A = 75 unit("m")^2$, flow velocity $v = 1 unit("m")/unit("s")$, specific heat of the water $c_p = 4180 unit("J")/(unit("kg") unit("K"))$, density of water $rho = 1000 unit("kg")/unit("m")^3$.)
]

The change in temperature resulting from adding the heat $Q$ to a body of mass $m$ and heat capacity $c_p$ is
$ Delta T = Q/(c_p m) = P/(c_p dot(m)). $ <eq:delta-t>
The rate at which water flows past the power station is $dot(m) = rho A v = 75 thin 000 unit("kg")/unit("s")$. To derive the power $P$, i.e. the amount of heat dumped into the water by the power station per second, we need to know its efficiency. The maximal possible efficiency is that of the idealized Carnot cycle, $eta_c = 1 - T_1/T_2$, which reversibly transfers energy from a warm region $T_2$ to a cool region $T_1 < T_2$ and, in the process, converts some of that energy to mechanical work. Thus
$ eta_"ps" = 1/2 eta_c = 1/2 (1 - (290 unit("K"))/(600 unit("K"))) approx 25.83 unit("%"). $
Solving $P_"out" = eta_"ps" P_"tot"$ and $P_"tot" = P_"out" + P$ for $P$, we find the energy released into the water per second to be
$ P = (1 - eta_"ps")/eta_"ps" P_"out" approx 2870 unit("MJ")/unit("s"). $
Inserting $dot(m)$ and $P$ into @eq:delta-t, we find a temperature increase for water flowing past the power station of
$ Delta T approx 9.16 unit("K"). $

= Carnot engine #points(2)

#task[
  The internal energy of two bodies consisting of the same substance is given by
  $ U = C T, $
  where $C$ is a constant. Their initial temperatures are $T_1$ and $T_2$, respectively. We let a Carnot engine work between the two bodies until both reach the final temperature $T_f$. What is $T_f$, and how much work has been produced when it is reached?
]

Since a Carnot engine works reversibly, it produces no change in entropy, $Delta S = 0$. Moreover, due to reversibility, the second law of thermodynamics (for closed systems) $delta Q <= T dif S$ holds as an equality. Together with $delta Q = C dif T$, this gives
$ 0 = integral dif S = integral dif S_1 + integral dif S_2 = C integral_(T_1)^(T_f) (dif T)/T + C integral_(T_2)^(T_f) (dif T)/T = C ln(T_f^2/(T_1 T_2)), $
from which we infer $T_f = sqrt(T_1 T_2)$. To calculate the work performed during equilibration, note that the two bodies form a closed system and thus $Delta U = Delta Q + Delta W = 0$. Using $Delta Q = C integral dif T = C Delta T$, we find the individual heats to be
$ Delta Q_1 = C (T_f - T_1), #h(3em) Delta Q_2 = C (T_f - T_2). $
Thus the total work performed is
$
  Delta W & = -(Delta Q_1 + Delta Q_2) = -C (2 T_f - T_1 - T_2) = C (T_1 + T_2 - 2 sqrt(T_1 T_2)) \
          & = C (sqrt(T_1) - sqrt(T_2))^2.
$
